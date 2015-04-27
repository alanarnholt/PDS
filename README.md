# PDS

R package containing data sets for *Passion Driven Statistics*


### Version 0.1

### Alan T. Arnholt

**PDS**: Data sets for  *Passion Driven Statistics*

Please report any **bugs** or **suggestions** at:
<https://github.com/alanarnholt/PDS/issues>.

## Installation


You may download the most recent version using the [devtools](http://github.com/hdaley/devtools) function `install_github()` to install **PDS** in R.

However, you need to make sure you're set up to develop packages. This is platform specific:

* On Windows, download and install [Rtools](http://http://cran.r-project.org/bin/windows/Rtools/).
* On the Mac, make sure you have [Xcode](https://developer.apple.com/xcode/) installed.
* On Linux, make sure you have the R-dev packages installed.

You can check everything is installed correctly with the `has_devel()` function from the **devtools** package. Type the following at 
the **R** prompt:

```{S}
install.packages("devtools", dependencies = TRUE)    
devtools::has_devel()
```

If everything is installed correctly, the function will print some output and then return **TRUE**.

To install the **PDS** package, type the following at the **R** prompt:

```{S}
devtools::install_github('alanarnholt/PDS')
```

If you want the vignette (not complete yet), type the following at the **R** prompt:

```{S}
devtools::install_github('alanarnholt/PDS', build_vignettes = TRUE)
```

The **code books** for the data sets are in the **CodeBooks** folder of the installed package.  To see where your system has installed the **PDS** package, type the following at the **R** prompt:

```{S}
system.file(package = "PDS")
```


