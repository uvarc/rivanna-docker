Muview2 2.2a2

https://github.com/grahamrow/Muview2

## Usage on Rivanna
1. Log on to [FastX Web](https://www.rc.virginia.edu/userinfo/rivanna/logintools/fastx/)
1. Open a terminal (next to Firefox in the top bar)
1. Enter the following commands:

```
module load singularity
singularity pull muview docker://uvarc/muview2:2.2a2
./muview
```

## Known problems
Running `./muview <file>` will cause a segmentation fault. Please start up the GUI first and then open the file from the menu.
