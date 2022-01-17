remotes::install_github("jhelvy/xaringanBuilder")
library(xaringanBuilder)

remotes::install_github('rstudio/chromote')

# build_pdf(input = "xaringan_test.Rmd", output_file = "xaringan_test.pdf")

build_pdf(input = "rconf.Rmd", output_file = "rconf.pdf")
build_pptx(input = "rconf.Rmd", output_file = "rconf.pptx")
build_gif(input = "rconf.Rmd", output_file = "rconf.gif")

build_pptx(input = "rconf.Rmd",
           output_file = "rconf.pptx",
           partial_slides = TRUE

           )


# Xaringan --> PPTX
# library(slidex)

# Use pdf file to pptx with Adobe commercial tool


# https://www.garrickadenbuie.com/talk/extra-great-slides-nyhackr/

devtools::install_github("datalorax/slidex")
library(slidex)

pptx <- system.file("rconf.Rmd", "slidedemo.pptx", package = "slidex")

convert_pptx(path = pptx, author = "DA")

# 컴파일없이 바로 보기

# http://aispiration.com/comp_document/ds-presn.html

#remotes::install_github('yihui/xaringan', upgrade = TRUE)
xaringan::inf_mr()

# install.packages("slickR")
library(slickR)

kcd_template <- fs::dir_ls(path=".")

kcd_template_df <- tibble(page = glue::glue("{kcd_template}") )

slickR(kcd_template_df$page, height = 600)



slides_html <- "rconf.html"

# "print" HTML to PDF
pagedown::chrome_print("slides.html", output = "slides.pdf")

# how many pages?
pages <- pdftools::pdf_info("slides.pdf")$pages

# set filenames
filenames <- sprintf("slides/slides_%02d.png", 1:pages)

# create slides/ and convert PDF to PNG files
dir.create("slides")
pdftools::pdf_convert("slides.pdf", filenames = filenames)

# Template for markdown containing slide images
slide_images <- glue::glue("
---

![]({filenames}){{width=100%, height=100%}}

")
slide_images <- paste(slide_images, collapse = "\n")

# R Markdown -> powerpoint presentation source
md <- glue::glue("
---
output: powerpoint_presentation
---

{slide_images}
")

cat(md, file = "slides_powerpoint.Rmd")

# Render Rmd to powerpoint
rmarkdown::render("slides_powerpoint.Rmd")  ## powerpoint!
