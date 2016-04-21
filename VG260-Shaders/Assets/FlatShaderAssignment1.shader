Shader "custom/flat"{
	Properties{
		_MainTex("Main Texture", 2D) = "white" {}
	}
	SubShader{
		Pass{
			CGPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag


			#include "UnityCG.cginc"


			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;

			
		
			//input
			struct appdata{
				float4 vertex : POSITION;
				float4 texcoord : TEXCOORD0;
				

			};
			//output
			struct v2f{
				float4 vertex : SV_POSITION;
				float2 tex : TEXCOORD0;
				float2 uv :TEXCOORD1;
				
			};
			//vertex shader program/function
			v2f vert(appdata v){
				v2f o;
				o.tex = v.texcoord;
				o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}
			
			float4 frag (v2f i): COLOR {
				float4 textureColor = tex2D(_MainTex, i.tex.xy * _MainTex_ST.xy + _MainTex_ST.zw);
			
				float2 uv = i.uv;
				float l = length(uv);
				float a = _Time.y * 0.5;
				uv = mul(float2x2(cos(a),sin(a),-sin(a),cos(a) ),uv);
				float r = float2(atan2(uv.y, uv.x) * 0.05, 1).x;

				return float4(1,1,1,1);
			}
			
			
			ENDCG
		}
	}
	
	//comment out during development
	//Fallback"diffuse"
}
