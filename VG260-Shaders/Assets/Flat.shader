Shader "custom/flat"{
	Properties{
		_Color("Color",Color)=(1,1,1,1)
		_SpecColor ("SpecColor", Color) = (1,1,1,1)
		_Shininess ("Shininess", Float) = 10
		_Atten ("Attenuation", Float) = 1
	}
	SubShader{
		Pass{
			Tags { "LightMode" = "ForwardBase" }
			CGPROGRAM
			
			//prgamas
			#pragma vertex vert
			#pragma fragment frag
			
			//user input
			uniform float4 _Color;
			uniform float4 _SpecColor;
			uniform float _Shininess;
			uniform float _Atten;
		
			
			//user input
			uniform float4 _LightColor0;		
			
			//input
			struct appdata{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};
			
			//output
			struct v2f{
				float4 vertex : SV_POSITION;
				float4 worldPosition : TEXCOORD0;
				float3 noramlDirection : TEXCOORD1;
			};

			//vertex shader program/function
			v2f vert(appdata v){
				v2f o;	

				o.worldPosition= mul(_Object2World, v.vertex);
				o.noramlDirection = normalize(mul(v.normal, _World2Object).xyz);

				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);		
				return o;
			}
			
			float4 frag (v2f i): COLOR {

		
				//normalDirection= normal of the vertex/(pixel)
				float3 noramlDirection = i.noramlDirection;
				
				//noramlize
				float3 viewDirection = normalize( _WorldSpaceCameraPos.xyz- i.worldPosition );
				
				//lightDirection=light direction
				float4 lightDirection = normalize(_WorldSpaceLightPos0);
				float atten = _Atten;


				// lighting

				//diffuse reflection is attenuation * light color * the dot product of the normal direction and light direction
				float3 diffuseReflection = atten * _LightColor0.xyz * max( 0.0, dot(noramlDirection, lightDirection) );

				// specular reflection is attenuation * spec color * the dot product of the normal direction and light direction * the dot product of the reflected inverse light direction and normal direction and view direction to the power of shininess
				float3 specularReflection = atten * _SpecColor.rgb * max( 0.0, dot(noramlDirection, lightDirection) ) * pow( max( 0.0, dot( reflect( -lightDirection, noramlDirection ), viewDirection ) ), _Shininess );

				// light final is diffuse reflection + specular reflection + ambient light
				float3 lightFinal = diffuseReflection + specularReflection + UNITY_LIGHTMODEL_AMBIENT;
			 return float4(lightFinal * _Color.rgb, 1.0) ;
			}
			
			ENDCG
		}
	}
	
	//comment out during development
	//Fallback"diffuse"
}
