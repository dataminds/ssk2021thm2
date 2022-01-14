remotes::install_github("jhelvy/xaringanBuilder")
library(xaringanBuilder)

remotes::install_github('rstudio/chromote')

# build_pdf(input = "xaringan_test.Rmd", output_file = "xaringan_test.pdf")

build_pdf(input = "rconf.Rmd", output_file = "rconf.pdf")
build_pptx(input = "rconf.Rmd", output_file = "rconf.pptx")
build_gif(input = "rconf.Rmd", output_file = "rconf.gif")

# Xaringan --> PPTX
# library(slidex)

# Use pdf file to pptx with Adobe commercial tool
