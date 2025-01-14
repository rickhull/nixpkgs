{ lib
, bleak-retry-connector
, bluetooth-data-tools
, bluetooth-sensor-state-data
, buildPythonPackage
, fetchFromGitHub
, home-assistant-bluetooth
, poetry-core
, pycryptodomex
, pytestCheckHook
, pythonOlder
, sensor-state-data
}:

buildPythonPackage rec {
  pname = "xiaomi-ble";
  version = "0.10.0";
  format = "pyproject";

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "Bluetooth-Devices";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-qpGw9c7O8MC6AEutRIqCEdZncJSQKesaHFRQjOxpa2U=";
  };

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    bleak-retry-connector
    bluetooth-data-tools
    bluetooth-sensor-state-data
    home-assistant-bluetooth
    pycryptodomex
    sensor-state-data
  ];

  checkInputs = [
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=xiaomi_ble --cov-report=term-missing:skip-covered" ""
  '';

  pythonImportsCheck = [
    "xiaomi_ble"
  ];

  meta = with lib; {
    description = "Library for Xiaomi BLE devices";
    homepage = "https://github.com/Bluetooth-Devices/xiaomi-ble";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
