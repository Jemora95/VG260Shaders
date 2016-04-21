Shader "custom/flat"{
	Properties{
	}
	SubShader{
		Pass{
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag
		
			//input
			struct appdata{
				float4 vertex : POSITION;
			};
			//output
			struct v2f{
				float4 vertex : SV_POSITION;
				
			};
			//vertex shader program/function
			v2f vert(appdata v){
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}
			
			float4 frag (v2f i): COLOR {
			 return float4(1,1,1,1);
			}
			
			ENDCG
		}
	}
	
	//comment out during development
	//Fallback"diffuse"
}
