Shader "CookbookShaders/BasicDiffuse"
{
	Properties
	{
		//_MainTex ("Base (RGB)", 2D) = "white" {}
		_EmissiveColor ("Emissive Color", Color) = (1,1,1,1)
		_AmbientColor ("Ambient Color", Color) = (1,1,1,1)
		_MySliderValue ("This is a Slider", Range(0,10)) = 2.5
		_RampTex ("Ramp Texture", 2D) = "white"{}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
			//#pragma surface surf Lambert
			#pragma surface surf BasicDiffuse
			inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten)
			{
				//float difLight = max(0, dot (s.Normal, lightDir));
				float difLight = dot (s.Normal, lightDir);
				float hLambert = difLight * 0.5 + 0.5;

				float4 col;
				//col.rgb = s.Albedo * _LightColor0.rgb * (difLight * atten * 2);
				col.rgb = s.Albedo * _LightColor0.rgb * (hLambert * atten * 2);
				col.a = s.Alpha;
				return col;
			}
			//sampler2D _MainTex;
			float4 _EmissiveColor;
			float4 _AmbientColor;
			float _MySliderValue;
			struct Input
			{
				float2 uv_MainTex;
			};
			void surf (Input IN, inout SurfaceOutput o)
			{
				//half4 c = tex2D (_MainTex, IN.uv_MainTex);
				//o.Albedo = c.rgb;
				//o.Alpha = c.a;
				float4 c;
				c = pow((_EmissiveColor + _AmbientColor), _MySliderValue);
				o.Albedo = c.rgb;
				o.Alpha = c.a;
			}


		ENDCG
	}
	FallBack "Diffuse"
}