#pragma once
#include "WindowInfo.h"

namespace GraphicsEngine
{
	class Device
	{
	public:
		void Initialize(WindowInfo& info);

		void Release();

		ComPtr<ID3D11Device> GetDevice() { return _device; }

		ComPtr<ID3D11DeviceContext> GetDeviceContext() { return _deviceContext; }

		ComPtr<IDXGIFactory> GetDXGI() { return _dxgi; }

		ComPtr<IDXGIAdapter> GetAdapter() { return _dxgiAdapter; }

	private:
		// COM(Component Object Model)
		// - DX의 프로그래밍 언어 독립성과 하위 호환성을 가능하게 하는 기술
		// - COM 객체(COM 인터페이스)를 사용. 세부사항은 우리한테 숨겨짐
		// - ComPtr 일종의 스마트 포인터
		ComPtr<IDXGIFactory1>	_dxgi;				// 화면 관련 기능들

		ComPtr<ID3D11Device>	_device;			// 각종 객체 생성

		ComPtr<ID3D11Device1>	_device1;

		ComPtr<ID3D11DeviceContext> _deviceContext;

		ComPtr<ID3D11DeviceContext1> _deviceContext1;

		ComPtr<IDXGIAdapter>	_dxgiAdapter;
	};
}