IF "%DESIRED_PYTHON%"=="" (
    echo DESIRED_PYTHON is NOT defined.
    exit /b 1
)

:: Create a new conda environment
setlocal EnableDelayedExpansion
FOR %%v IN (%DESIRED_PYTHON%) DO (
    set PYTHON_VERSION_STR=%%v
    set PYTHON_VERSION_STR=!PYTHON_VERSION_STR:.=!
    conda remove -n py!PYTHON_VERSION_STR! --all -y || rmdir %CONDA_HOME%\envs\py!PYTHON_VERSION_STR! /s
    if "%%v" == "3.9" call conda create -n py!PYTHON_VERSION_STR! -y numpy=2.0.1 boto3 cmake=3.31.2 ninja typing_extensions setuptools=72.1.0 python=%%v
    if "%%v" == "3.10" call conda create -n py!PYTHON_VERSION_STR! -y -c=conda-forge numpy=2.0.1  boto3 cmake=3.31.2 ninja typing_extensions setuptools=72.1.0 python=%%v
    if "%%v" == "3.11" call conda create -n py!PYTHON_VERSION_STR! -y -c=conda-forge numpy=2.0.1  boto3 cmake=3.31.2 ninja typing_extensions setuptools=72.1.0 python=%%v
    if "%%v" == "3.12" call conda create -n py!PYTHON_VERSION_STR! -y -c=conda-forge numpy=2.0.1  boto3 cmake=3.31.2 ninja typing_extensions setuptools=72.1.0 python=%%v
    if "%%v" == "3.13" call conda create -n py!PYTHON_VERSION_STR! -y -c=conda-forge numpy=2.1.2  boto3 cmake=3.31.2 ninja typing_extensions setuptools=72.1.0 python=%%v
    if "%%v" == "3.13t" call conda create -n py!PYTHON_VERSION_STR! -y -c=conda-forge numpy=2.1.2 boto3 cmake=3.31.2 ninja typing_extensions setuptools=72.1.0 python-freethreading python=3.13
    call conda run -n py!PYTHON_VERSION_STR! pip install pyyaml
    call conda run -n py!PYTHON_VERSION_STR! pip install mkl-include
    call conda run -n py!PYTHON_VERSION_STR! pip install mkl-static
)
endlocal

:: Install libuv
conda install -y -q -c conda-forge libuv=1.39
set libuv_ROOT=%CONDA_HOME%\Library
echo libuv_ROOT=%libuv_ROOT%
