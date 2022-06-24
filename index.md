### Interacting with APIs: Example with the Financial data API

I am creating a vignette to show how to contact an API using functions I’ve created to query, parse, and return well-structured data.  Then we'll use them to do some exploratory data analysis.

## Requirements 

To use the functions for interacting with the Financial data API, I used the following packages:  

- httr 
- jsonlite 
- tidyverse 
- devtools 

## API Interaction Functions

The first challenge with this API was dealing with the variable names.  The default names are not preferable to work with when doing data analysis, so I renamed some of the variables to make them readable.  Once I selected and renamed the variables to make them readable, I wanted to calculate the percentage change between the stock's open and close price.  Now that I have the stock's percentage change, I wanted to output the day's best and worse performers.  To make things values look nice, I applied some formatting to the values.          

 

You can use the [editor on GitHub](https://github.com/dkorver/food/edit/gh-pages/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [Basic writing and formatting syntax](https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/dkorver/food/settings/pages). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.
