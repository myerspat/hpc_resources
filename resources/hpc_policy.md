# AIMS Cluster Usage Policy

This section outlines the policies for using any AIMS cluster. These are in place to ensure individual users are respected. Please read and follow these carefully. Policy violators are at risk of having their task terminated and cereal offenders may loose access to AIMS clusters.

## Package Installation

Packages should be installed locally within your home directory unless the installation requires root privileges. This should not be the case for most software with most including options to download locally at the user level. If no other options exist without root privileges, make a request for a package installation in the `#aims-clusters` Slack channel and detail the following:

```slack
Package Installation Request
- Pakcage Name:
- Reason: <Why you need this package and why you can't do it yourself on the user level>
- Installation Resources: <Relavent links and documentation that might make installation with root privilages quick>
```

## Resource Utilization

Resource utilization will depend on the priority of the task taking into account deadlines and applications. The AIMS clusters are meant for low to medium workloads with an emphasis on software development and debugging. Heavier workloads should be reserved for established HPCs. AIMS has access to the following HPCs

- [INL HPC](https://inl.gov/ncrc/)

Below includes the guidelines for utilizing the computational resources of the AIMS clusters. Following these guidelines respects the time of other researchers using the machines.

### CPUs

For managing CPU utilization we will use the native Linux commands `nice` and `renice`. These commands determine the priority of your tasks and allows the system to automatically allocate resources depending on process priority. Without running a command with `nice`, your task would have a value of 0 as shown in the NI column of `htop` for the Jupyter Notebook run by `myerspat` below.
![[supporting/htop_0.png]]
The `nice` value ranges from -20 to 19 with a lower number indicating a higher priority. Negative `nice` values are reserved for system processes executed by the root as these are a necessity. Users are limited to the range of 0 to 19. To run a command with a `nice` value of 15 you simply add `nice -15` before your command. For example, when launching a Jupyter Notebook like shown above, we can run
```sh
nice -15 jupyter notebook
```
Therefore, any Python code executed by the notebook is subject to that priority. Running `htop` again we see
![[./supporting/htop_15.png]]
Notice the values for `myerspat`'s notebook in the NI column has changed to 15 and the CPU utilization by these processes (shown in the bars at the top) have changed color to a blue. Processes with a higher priority value (negative `nice`) become more red while lower priority tasks become blue with 0 being green. These colors should aid other users in determining how free the system is for processes they may submit.

`nice` allows users to execute commands that may use all CPUs; however, how nice you are to others dictates how willing you are to relinquish resources to other processes. Therefore, during low activity you will be able to use all CPU resources. This ensures you are not restricted to a certain set of resources even when all CPUs are open. 

With this introduction to `nice` we outline below the policy for `nice` values. `nice` must be applied to all long running commands a user executes (anything more than 3 minutes). 
- Values between 15-19 are for day-to-day operations including **debugging and short running tasks**. These should encompass a majority of the low workload tasks any user submits. A user may submit any number of commands with this value at any given time. 
- Values between 10-14 are for **standard workloads** where bugs in scripts have all been fixed and a final run to produce results is needed. A user is limited to two 10-14 commands at any given time.
- Any values that fall between 0-9 are **higher priority executions** in which you must notify other users in the `#aims-clusters` Slack channel. Include the following in your notification
```slack
AIMS0X Execution Notification
- Username: 
- Script Name: 
- Nice Value: 
- GPU(s): 
- Expected fully utilized CPUs (Number of Threads): 
- Execution Time Estimate: 
- Reason for 0-9 Priority: 
```
A user is limited to one 0-9 priority execution at any given time. Please change `X` to match the cluster you are running this task on. Following the completion of this task, please add a checkmark emoji to the Slack message to show the resources have been freed.

Please respect these guidelines for running scripts on any AIMS cluster. **Any process should not run longer than 48 hours.**  Activity may vary from day-to-day; therefore, the System Admin reserves the right to reallocate priority of existing processes using `renice`.  If a user feels a process or other user is violating these guidelines, contact the System Admin. Users found in violation are subject to task termination of `renice`.

### GPUs

GPUs do not come with native resource allocation commands such as `nice` and `renice`; therefore, the guidelines around this hardware is on all users to enforce and follow. Additionally, the number of total available GPUs in the AIMS cluster system are much less than available CPU threads. The policy around GPUs is as follows
- Any user is allowed to submit one job utilizing a single GPU that may last as long as 5 hours without notifying other users.
- Users are freely allowed to launch an additional job that may not last longer than 30 minutes (for debugging or short workloads).
- A user may also submit a parallel job using at most 2 GPUs lasting not longer than 1 hour (for parallel testing) without notification to other users.
- **All other jobs may not utilize more than 2 GPUs for up to 48 hours.** Additionally, you must notify other users in the `#aims-clusters` channel outlining the same information for resource notification discussed in the CPUs section. If you are not relying heavily on CPUs and your `nice` level is not between 0-9 then you do not need to comment on `nice` value.

It is up to the users to ensure their tasks are following these guidelines; however, a common command for limiting GPU utilization is the `CUDA_AVAILABLE_DEVICES` environment variable. This variable controls which GPU the task runs on. For example, we can run a Python script, `my_script.py`, on GPU 1 with the following
```sh
CUDA_AVAILABLE_DEVICE=1 python my_script.py
```
Users who do not follow these guidelines may have their scripts terminated by the System Admin. Additionally, cereal offenders may loose access to AIMS clusters. 