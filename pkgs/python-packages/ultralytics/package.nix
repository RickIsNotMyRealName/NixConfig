{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, pytest-runner
}:

buildPythonPackage rec {
  pname = "ultralytics";
  version = "8.2.45";

  src = fetchPypi {
    inherit pname version;
    sha256 = "";
  };

  checkInputs = [
    pytestCheckHook
    pytest-runner
  ];

  propagatedBuildInputs = [
    
  ];

  meta = with lib; {
    description = "Ultralytics YOLOv8 for SOTA object detection, multi-object tracking, instance segmentation, pose estimation and image classification.";
    homepage    = "https://pypi.org/project/ultralytics/";
  };
}