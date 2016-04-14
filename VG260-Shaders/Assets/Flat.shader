Shader "custom/flat"{
	Properties{
		_Color("Color",Color)=(1,1,1,1)
	}
	SubShader{
		Pass{
			
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
			
			uniform float4 _Color;
			uniform float4 _LightColor0;
			
			//input
			struct appdata{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};
			//output
			struct v2f{
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
			};
			//vertex shader program/function
			v2f vert(appdata v){
				v2f o;
				
				//normalDirection= normal of the vertex/(pixel)
				float3 normalDirection =   mul( v.normal,_World2Object).xyz;
				
				//lightDirection=light direction
				float3 lightDirection = _WorldSpaceLightPos0.xyz;
				
				//diffuseReflection= _LightColor0 * dot(normalDirection, lightDirection);
				float3 diffuseReflection =_Color* _LightColor0 * dot(normalDirection, lightDirection);
				

				o.color = float4(diffuseReflection, 1);
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}
			
			float4 frag (v2f i): COLOR {
			 return i.color;
			}
			
			ENDCG
		}
	}
	
	//comment out during development
	//Fallback"diffuse"
}
