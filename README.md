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
```
git clone https://github.com/hm-aemy/hm-openpdk-library.git
```
Define the PDK:
```
export PDK=ihp-sg13g2 #or ihp-sg13cmos5l
```
Setup the environment:
```
source setup.sh
```

## Fetching the PDK

The repository includes a Makefile to clone the required PDK version.

Makefile uses the PDK that was setup on the previous step:
```
make clone-pdk
```
To remove the cloned PDK:
```
make clean
```

This repository is licensed nder the Apache License 2.0. See the LICENSE file for details.
