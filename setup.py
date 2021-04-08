from setuptools import setup

setup(
    name='AsymTools2',
    version='2.0',
    packages=['asymtools'],
    url='',
    license='',
    author='Nicholas Haradhvala',
    author_email='njharlen@broadinstitute.org',
    description='Tools for the annotation and visualization of mutational strand asymmetries',
    package_data={'asymtools': ['reference/*.txt']},
    include_package_data=True
)
