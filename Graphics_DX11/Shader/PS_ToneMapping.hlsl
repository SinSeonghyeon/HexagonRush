#include "ConstantBuffer.hlsli" 

struct VS_IN
{
    float3 pos : POSITION;
    float2 uv : TEXCOORD;
    float3 normal : NORMAL;
    float3 tangent : TANGENT;
    float4 color : COLOR;
};

struct VS_OUT
{
    float4 pos : SV_POSITION;
    float4 color : COLOR;
    float2 uv : TEXCOORD;
    float3 normal : NORMAL;
    float3 tangent : TANGENT;
    float3 world : POSITION;
};

Texture2D Texture_Final : register(t0);

SamplerState Sam_Clamp : register(s0);      // 샘플러 (Clamp)

// HDR 기능을 사용 중이라면 마지막으로 Back Buffer에 쏘는 쉐이더 코드가 될 듯.
float4 PS_ToneMapping(VS_OUT input) : SV_TARGET
{
    float4 color = (float4) 0.f;
    
#ifdef USE_REINHARD
    color = Texture_Final.Sample(Sam_Clamp, input.uv);
        
    color *= _exposure;
    
    color = color / (1 + color);
    
    // 마지막에 감마 연산 필요
    color = pow(color, (1 / 2.2f));
#endif
    
#ifdef USE_FILMIC
    color = Texture_Final.Sample(Sam_Clamp, input.uv);
    
    color *= _exposure;
    
    color = max(0, color - 0.004f);
    
    // 마지막에 감마 연산 불필요
    color = (color * (6.2 * color + 0.5)) / (color * (6.2f * color + 1.7f) + 0.06);
#endif
    
    color.a = 1.f;
    
    return color;
}