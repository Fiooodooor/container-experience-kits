# Container Experience Kits (CEK) Profiles Generation

1. [Installing Dependencies](#install-dependencies-using-one-of-the-following-methods)
2. [Creating Sample Profiles](#creating-sample-profiles)
3. [Discover Supported Architectures](#discover-supported-architectures)
4. [Discover Supported Ethernet Network Adapters](#discover-supported-ethernet-network-adapters)
5. [Discover Supported Profiles](#discover-supported-profiles)
6. [Discover Additional Configuration](#discover-additional-configuration)
7. [Architecture and Ethernet Network Adapters type auto-detection](#architecture-and-ethernet-network-adapters-type-auto-detection)
8. [Example Commands](#example-commands)
9. [Playbooks Generation](#playbook-generation)

---

## Install Dependencies using one of the following methods

a) Non-invasive virtual environment using pipenv

```bash
pip3 install pipenv
pipenv install
# Then to run and use the environment
pipenv shell
```

b) Non-invasive virtual environment using venv

```bash
python3 -m venv venv
# Then to activate new virtual environment
source venv/bin/activate
# Install dependencies in venv
pip3 install -r requirements.txt
```

c) System wide environment (not recommended)

```bash
pip3 install -r requirements.txt
```

## Creating Sample Profiles

To create sample profiles one of the following commands must be executed:

```bash
make
```

or

```bash
make examples
```

After successful profiles generation, the results might be investigated in the `examples` directory.
The two directories should be visible:

* k8s - contains profiles deployable on the bare metal machines
* vm - contains profiles deployable on the virtual machines

These two directories represent available modes of the CEK project.

## Discover Supported Architectures

At the moment, Container Experience Kits supports the following machine architectures:

* `gnr` - Granite Rapids - 'Next Generation Intel(R) Xeon(R) Scalable Processor'
* `emr` - Emerald Rapids - '5th Generation Intel(R) Xeon(R) Scalable Processor'
* `spr` - Sapphire Rapids (default) - '4th Generation Intel(R) Xeon(R) Scalable Processor'
* `icx` - IceLake - '3rd Generation Intel(R) Xeon(R) Scalable Processor'
* `clx` - CascadeLake - '2nd Generation Intel(R) Xeon(R) Scalable Processor'
* `skl` - SkyLake - '1st Generation Intel(R) Xeon(R) Scalable Processor'

Architecture acronym, e.g. skl, will be passed to the make command via the optional `ARCH` parameter. It is important to be aware of the machine's type before generating profiles as some functionalities are exclusive for specific architectures.

## Discover Supported Ethernet Network Adapters

At the moment, Container Experience Kits supports the following Ethernet Network Adapters:

* `cvl` - Columbiaville (default) - 'Intel(R) Ethernet 800 Series Network Adapters'
* `fvl` - Fortville - 'Intel(R) Ethernet 700 Series Network Adapters'

Ethernet Network Adapter acronym, e.g cvl, will be passed to the make command via the optional `NIC` parameter.

## Discover Supported Profiles

At the moment, Container Experience Kits supports the following profiles:

* access
* basic
* on_prem
* regional_dc
* remote_fp
* storage
* build_your_own

Profile's name will be passed to the make command via the required `PROFILE` parameter. Each profile includes some specific sort of functionalities. Choose the profile that suits you the most via inspecting the examples generated [here](#creating-sample-profiles).
If you would like to know more about CEK profiles read section 2.2 in [here](https://networkbuilders.intel.com/solutionslibrary/network-and-cloud-edge-container-bare-metal-reference-system-architecture-user-guide).

## Discover Additional Configuration

At the moment, Container Experience Kits supports the following optional configuration:

* Configure mirrors for kubespray deployment - for detailed information, please read [mirrors guide](docs/mirrors.md)

## Architecture and Ethernet Network Adapters type auto-detection

Container Experience Kits can automatically detect your target machines architecture and Ethernet Network Adapter type.

```bash
# for k8s mode
make auto-k8s-profile PROFILE=remote_fp HOSTS=10.10.10.11,10.10.10.12 USERNAME=root
# or for vm mode
make auto-vm-profile PROFILE=remote_fp HOSTS=10.10.10.11,10.10.10.12 USERNAME=root
```

> **_NOTE:_** Make sure that SSH key is copied to all Kubernetes cluster nodes or VM hosts (`ssh-copy-id <user>@<host>` command can be used for that).

## Example Commands

To generate files needed for deployment of `remote_fp` profile, for `Sapphire Rapids` machines, in `k8s` mode, with `cvl` Ethernet Network Adapter the following command must be executed:

```bash
make k8s-profile PROFILE=remote_fp ARCH=spr NIC=cvl
```

To generate the same profile as above, but for `vm` mode, run:

```bash
make vm-profile PROFILE=remote_fp ARCH=spr NIC=cvl
```

The values of `PROFILE`, `ARCH` and `NIC` parameters are up to you. Please update accordingly.

If you run multiple of the above commands, you should see backups folder in your project root directory:

```bash
ls backups/
```
> **_NOTE:_** Above command will result in an output similar to this: "container-experience-kits$ backups/remote_fp_20221114_141523/" and within the mentioned folder location "group_vars, host_vars, inventory.ini" files can be found which will be backups of earlier prepared deployments.

Backups folder is created so that earlier prepared deployments are not lost. That way, you can easily switch between profiles deployment. Each backup contains a unique timestamp.

To clean files and directories that were created by make commands, please run:

```bash
make clean
```

This command will not remove backup directories. If you would like to remove all generated files and directories, please run:

```bash
make clean-all
```

## Playbook Generation

Before profiles generation playbooks are not available. To generate playbooks no additional command must be executed.  
They would be created as soon as the first `make` command is executed.
