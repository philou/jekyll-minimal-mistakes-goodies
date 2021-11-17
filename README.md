# Philou's Jekyll and Minimal Mistakes Blogging Goodies

Tips and automation scripts for blogging with [Jekyll](https://jekyllrb.com/) and [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/).

## Installation

Create a sub-module in your blog repo under the _scripts directory.

## Usage

Run the scripts from the root of your blog repo, `_scripts/_<command>`

## Notes and Troubleshooting

Here are common reminders and fixes.

### How to update gem dependencies

Gems need to be updated regularly:

`brew upgrade rbenv ruby-build`

`rbenv install --list`

`rbenv install xxx`

Update `.ruby-version`

`bundle update`

Test with `_scripts/_preview.sh` and `_scripts/_local_preview.sh`


### How to include figures with links and credits

Here is the template I am using :

```liquid
{% assign figure_path="/imgs/...todo.jpg" | absolute_url %}

{% assign figure_alt="TODO" %}

{% capture figure_caption %}
TODO markdown
{% endcapture %}

{% include figure image_path=figure_path alt=figure_alt caption=figure_caption %}
```

### Images best sizes

* Teaser images : 600x315, 72dpi, compressed for minimal size (appears on the front page!)
* Open Graph images : 1800x945, 250dpi, not compressed to appear well on high precision devices

### How to license an image

#### Visual stamp

1. Might be easier to resize the image to 1800x945 ratio (same as teaser images)
2. Stamp the image, use gimp and add the layer from insert-cc.xmp
3. Resize image as needed
4. Add credits to the image in the page

```liquid
{% assign figure_path="/imgs/...todo.jpg" | absolute_url %}

{% assign figure_alt="TODO" %}

{% capture figure_caption %}
By [Philippe Bourgau]({{site.url}}), under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/), [high resolution image]({{site.url}}{{site.baseurl}}/imgs/...todo.jpg)
{% endcapture %}

{% include figure image_path=figure_path alt=figure_alt caption=figure_caption %}
```

#### Add metadata

5. Generate .xmp metadata from [Creative Commons website](https://creativecommons.org/choose/#metadata)
6. Add the metadata to images with `exiftool -tagsFromFile CC_Attribution-ShareAlike_4.0_International.xmp xxx1.jpg xxx2.jpg...`

### Extracting bold sections from a post

This can be useful to generate tweets or variations for [Recurpost](https://recurpost.com).

`_scripts/_grep_tweets.sh POST_FILE_PATH`

This dump usually needs further editing.

TODO:
* This does not take the quotes into account
* It would be nice to uppercase the first letter

### Dumping the word count per post

Just run the following command:

```shell
find _posts -type f -and -name "*.markdown" -exec bundle exec ruby _word_count.rb {} \; > tmp/word_counts.csv
```

You'll need the following pre-requisites:

* Ruby
* Python3
* Init submodule markdown-word-count
