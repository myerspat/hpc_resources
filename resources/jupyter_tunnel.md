# SSH Tunneling with Jupyter Notebooks

An SSH tunnel allows you to run Jupyter Notebook code blocks on another machine. To get started add the following to `~/profile` on the AIMS machine of your choice:
```sh
# SSH tunnel for Jupyter
alias tunnel="jupyter notebook --no-browser --port=XXXX
```
where `XXXX` is a port number of your choice. Do not choose the following

- Patrick Myers: 8890

After resourcing your `~/bashrc`, anytime you run `tunnel` Jupyter will start, assuming your Python environment has Jupyter Notebooks installed. On your local machine add the following to your `~/.profile`:
```sh
alias tunnel="ssh -N -f -L localhost:8888:localhost:XXXX"
```
Again, resource your `~/.bashrc`. Now running `tunnel` locally will create an SSH tunnel from port 8888 of your machine to XXXX of the AIMS machine.

With both commands active, you can connect to the Jupyter browser at [http://localhost:8888/tree?](http://localhost:8888/tree?).  You'll be prompted to fill a password or token which is given in the output of the `tunnel` command on the AIMS machine. 
