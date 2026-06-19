# HM OpenPDK Library

Open-source custom cells and auxiliary design files used by the HM AEMY group for projects based on open PDKs.

## Repository structure

```text
.
├── Makefile
├── ihp-sg13g2/
│   ├── libs.ref/
│   └── libs.tech/
└── ihp-sg13cmos5l/
    └── libs.tech/
```

## Getting started

Clone the repository:

git clone https://github.com/hm-aemy/hm-openpdk-library.git

## Fetching the PDK

The repository includes a Makefile to clone the required IHP PDK version.

By default, the Makefile uses ihp-sg13g2:
```
make clone-pdk
```
To clone the ihp-sg13cmos5l setup:
```
make clone-pdk PDK=ihp-sg13cmos5l
```
This will clone the base IHP Open PDK and then fetch the ihp-sg13cmos5l repository inside the local pdk/ directory.

To remove the cloned PDK:
```
make clean
```

This repository is licensed nder the Apache License 2.0. See the LICENSE file for details.
