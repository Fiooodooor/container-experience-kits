# Container Experience Kits (CEK) Profiles Generation

1. [Installing Dependencies](#install-dependencies)
2. [Creating Sample Profiles](#creating-sample-profiles)
3. [Discover Supported Architectures](#discover-supported-architectures)
4. [Discover Supported Profiles](#discover-supported-profiles)
5. [Example Commands](#example-commands)
6. [Playbooks Generation](#playbook-generation)

---

## Install Dependencies:

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

* `spr` - Sapphire Rapids - '4th Generation Intel(R) Xeon(R) Scalable Processor'
* `icx` - IceLake (default) - '3rd Generation Intel(R) Xeon(R) Scalable Processor'
* `clx` - CascadeLake - '2nd Generation Intel(R) Xeon(R) Scalable Processor'
* `skl` - SkyLake - '1st Generation Intel(R) Xeon(R) Scalable Processor'

Architecture acronym, e.g. skl, will be passed to the make command via the optional `ARCH` parameter. It is important to be aware of the machine's type before generating profiles as some functionalities are exclusive for specific architectures.

## Discover Supported Profiles

At the moment, Container Experience Kits supports the following profiles:

* access
* basic
* full_nfv
* on_prem
* regional_dc
* remote_fp
* storage

Profile's name will be passed to the make command via the required `PROFILE` parameter. Each profile includes some specific sort of functionalities. Choose the profile that suits you the most via inspecting the examples generated [here](#creating-sample-profiles).
If you would like to know more about CEK profiles read section 2.2 in [here](https://networkbuilders.intel.com/solutionslibrary/container-bare-metal-for-2nd-3rd-generation-intel-xeon-scalable-processor).


## Example Commands

To generate files needed for deployment of `full_nfv` profile, for `Sapphire Rapids` machines, in `k8s` mode, the following command must be executed:

```bash
make k8s-profile PROFILE=full_nfv ARCH=spr
```

To generate the same profile as above, but for `vm` mode, run:

```bash
make vm-profile PROFILE=full_nfv ARCH=spr
```

The values of both `PROFILE` and `ARCH` parameters are up to you. Please update accordingly.

If you run both commands from above, you should see backups folder in your project root directory:

```bash
ls backups/
```
> **_NOTE:_** Above command will result in an output similar to this: "container-experience-kits$ backups/full_nfv_20220121_141523/" and within the mentioned folder location "group_vars, host_vars, inventory.ini" files can be found which will be backup of earlier prepared deployments.

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
