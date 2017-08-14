from setuptools import setup, find_packages

# Origin Source Information
# url = "https://github.com/giulbia/baby_cry_detection.git"
# author = 'Giulia Bianchi'
# author_email = "gbianchi@xebia.fr"

setup(
    name='pcBCD',
    version='3.0.1',
    description='Classification of signals to detect baby cry',
    url="https://github.com/mystesPF/BabyCryingDetector",
    author='Bankruptcy',
    author_email="lasiyan1130@gmail.com",
    license='new BSD',
    packages=find_packages(),
    install_requires=['numpy', 'pandas', 'scipy', 'sklearn', 'pydub', 'librosa'],
    tests_require=['pytest', "unittest2"],
    scripts=[],
    py_modules=["pcBCD"],
    include_package_data=True,
    zip_safe=False
)
