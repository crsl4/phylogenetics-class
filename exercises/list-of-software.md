# Software for Botany 563

I am creating this list after a student requested it, but **people do not have to install these software ahead of class**. 
This is not a complete list for the whole semester.


**Instructions:** If you encounter any problems and had to find solutions online, please document those problems and solutions here. You can fork this class repository and add your description of problems/solutions via a pull request. I am very interested to know if people struggle in certain ways to install this software in order to create a more detailed set of instructions to install these tools in the future.


- [phyluce](https://phyluce.readthedocs.io/en/latest/purpose.html)
- [ClustalW](http://www.clustal.org/clustal2/)
- [T-Coffee](http://www.tcoffee.org/Projects/tcoffee/index.html#DOWNLOAD)
- [MUSCLE](https://www.drive5.com/muscle/downloads.htm)



## Trouble-shooting

Please include here any issue (and solution) that you encountered if you decide to install these software by yourself.

### ClustalW

Mac users with newest OS can run into problems when installing ClustalW.
From a student: I also had a similar problem, where I was getting the error:
```
Bad CPU type in executable
```
which meant that the OS version was too advanced. But I ended up able to install clustalw using conda:
```
conda create -n clustalw2 -c biobuilds -y clustalw
```