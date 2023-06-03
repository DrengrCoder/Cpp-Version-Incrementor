# Template project code

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

A compliant README must satisfy all the requirements listed below.

> Note: Standard Readme is designed for open source libraries. Although it's [historically](README.md#background) made for Node and npm projects, it also applies to libraries in other languages and package managers.

**Requirements:**
  - Be called README.md (with capitalization).
  - If the project supports i18n, the file must be named accordingly: `README.de.md`, where `de` is the BCP 47 Language tag. For naming, prioritize non-regional subtags for languages. If there is only one README and the language is not English, then a different language in the text is permissible without needing to specify the BCP tag: e.g., `README.md` can be in German if there is no `README.md` in another language. Where there are multiple languages, `README.md` is reserved for English.
  - Be a valid Markdown file.
  - Sections must appear in order given below. Optional sections may be omitted.
  - Sections must have the titles listed below, unless otherwise specified. If the README is in another language, the titles must be translated into that language.
  - Must not contain broken links.
  - If there are code examples, they should be linted in the same way as the code is linted in the rest of the project.

## Table of Contents

_Note: This is only a navigation guide for the specification, and does not define or mandate terms for any specification-compliant documents._

- [Formatting](#formatting)
- [Sections](#sections)
  - [Title](#title)
  - [Banner](#banner)
  - [Badges](#badges)
  - [Short Description](#short-description)
  - [Long Description](#long-description)
  - [Table of Contents](#table-of-contents-1)
  - [Security](#security)
  - [Background](#background)
  - [Install](#install)
  - [Usage](#usage)
  - [Extra Sections](#extra-sections)
  - [API](#api)
  - [Maintainers](#maintainers)
  - [Thanks](#thanks)
  - [Contributing](#contributing)
  - [License](#license)
- [Definitions](#definitions)

## Formatting

_Defining table of contents is the back-bone of a readme document, follow the example within this file, with every title entry following a hyphon and every sub entry following a double space plus a hyphon. Every subsequent sub entry should follow additional double space's before the hyphon._

_Defining titles and headings is done with hash-tags ( # ):_
- The increasing number of hash tags defines the decreasing size of the title; 1 hash tag is the biggest title and every subsequent hash tag makes the title smaller. All hash tag'd titles are bold.
- 1 hash should be used for the title of the project / readme document.
- 2 hash's should be used for the table of contents title and titles within the table of contents that label each section. Don't forget to label the title with a link to quickly jump to the section, as defined in this document.
- 3 hash's should be used for sub entries to every title entry.
- Any number of sub entries can be added to entry title entry and subsequent sub entries as long as the number of space has been appropriately defined.

_Defining sub headings within a title headed section should be bold, and an item can be made bold by using double asterisks around the piece of text. This is done like **so, this is a piece of bold text or other representation of text that is separate to readme text**, within the readme document._

_If you want to define things in italic text, surround the text with underscores like this entire section has been written._

_Certain text should be defined similar to how a quotation would be defined within a MS word document. This is done by surrounding it with specific text like so:_

```markdown
This is standardised markdown quote-like text.
```

_Check the readme document for specific details. The apostrophe-like mark is a backwards apostrophe and can be used with the key that is often above the tab key on a UK windows keyboard._

_Parts of the text can be defined as code or other types of text that should be noterised as being separate to the typical readme text, this can be done by surrounding the text with the backwards apostrophe like `so, this is a piece of code or other representation of text that is separate to readme text`, and you should see the readme document for details._

_Text can be linked to other parts of the document or have web links attached to them. To do this, you need to surround the text with square brackets "[" and "]" and follow it immediately with a link in regular brackets "(" and ")". The link within the regular brackets can be a URL or a link to another part of the document. Links to other parts of the document need to be defined with the hash tag at the beginning of the text within the brackets, along with a title that has been defined in another part of the document. The link to the other part of the document must be a heading of sub heading section that has been defined with a hash tag at the start of the line of text. [This text is a link to google](https://www.google.co.uk)_

## Sections

### Title
**Status:** Required.

**Requirements:**
- Title must match repository, folder and package manager names - or it may have another, relevant title with the repository, folder, and package manager title next to it in italics and in parentheses. For instance:

  ```markdown
  # Standard Readme Style _(standard-readme)_
  ```

  If any of the folder, repository, or package manager names do not match, there must be a note in the [Long Description](#long-description) explaining why.

**Suggestions:**
- Should be self-evident.

### Banner
**Status:** Optional.

**Requirements:**
- Must not have its own title.
- Must link to local image in current repository.
- Must appear directly after the title.

### Badges
**Status:** Optional.

**Requirements:**
- Must not have its own title.
- Must be newline delimited.

**Suggestions:**
- Use http://shields.io or a similar service to create and host the images.
- Add the [Standard Readme badge](https://github.com/RichardLitt/standard-readme#badge).

### Short Description
**Status:** Required.

**Requirements:**
- Must not have its own title.
- Must be less than 120 characters.
- Must not start with `> `
- Must be on its own line.
- Must match the description in the packager manager's `description` field.
- Must match GitHub's description (if on GitHub).

**Suggestions:**
- Use [gh-description](https://github.com/RichardLitt/gh-description) to set and get GitHub description.
- Use `npm show . description` to show the description from a local [npm](https://npmjs.com) package.

### Long Description
**Status:** Optional.

**Requirements:**
- Must not have its own title.
- If any of the folder, repository, or package manager names do not match, there must be a note here as to why. See [Title section](#title).

**Suggestions:**
- If too long, consider moving to the [Background](#background) section.
- Cover the main reasons for building the repository.
- "This should describe your module in broad terms,
generally in just a few paragraphs; more detail of the module's
routines or methods, lengthy code examples, or other in-depth
material should be given in subsequent sections.

  Ideally, someone who's slightly familiar with your module should be
able to refresh their memory without hitting "page down". As your
reader continues through the document, they should receive a
progressively greater amount of knowledge."

  ~ [Kirrily "Skud" Robert, perlmodstyle](http://perldoc.perl.org/perlmodstyle.html)

### Table of Contents
**Status:** Required; optional for READMEs shorter than 100 lines.

**Requirements:**
- Must link to all Markdown sections in the file.
- Must start with the next section; do not include the title or Table of Contents headings.
- Must be at least one-depth: must capture all `##` headings.

**Suggestions:**
- May capture third and fourth depth headings. If it is a long ToC, these are optional.

### Security
**Status**: Optional.

**Requirements:**
- May go here if it is important to highlight security concerns. Otherwise, it should be in [Extra Sections](#extra-sections).

### Background
**Status:** Optional.

**Requirements:**
- Cover motivation.
- Cover abstract dependencies.
- Cover intellectual provenance: A `See Also` section is also fitting.

### Install
**Status:** Required by default, optional for [documentation repositories](#definitions).

**Requirements:**
- Code block illustrating how to install.

**Subsections:**
- `Dependencies`. Required if there are unusual dependencies or dependencies that must be manually installed.

**Suggestions:**
- Link to prerequisite sites for programming language: [npmjs](https://npmjs.com), [godocs](https://godoc.org), etc.
- Include any system-specific information needed for installation.
- An `Updating` section would be useful for most packages, if there are multiple versions which the user may interface with.

### Usage
**Status:** Required by default, optional for [documentation repositories](#definitions).

**Requirements:**
- Code block illustrating common usage.
- If CLI compatible, code block indicating common usage.
- If importable, code block indicating both import functionality and usage.

**Subsections:**
- `CLI`. Required if CLI functionality exists.

**Suggestions:**
- Cover basic choices that may affect usage: for instance, if JavaScript, cover promises/callbacks, ES6 here.
- If relevant, point to a runnable file for the usage code.

### Extra Sections
**Status**: Optional.

**Requirements:**
- None.

**Suggestions:**
- This should not be called `Extra Sections`. This is a space for 0 or more sections to be included, each of which must have their own titles.
- This should contain any other sections that are relevant, placed after [Usage](#usage) and before [API](#api).
- Specifically, the [Security](#security) section should be here if it wasn't important enough to be placed above.

### API
**Status:** Optional.

**Requirements:**
- Describe exported functions and objects.

**Suggestions:**
- Describe signatures, return types, callbacks, and events.
- Cover types covered where not obvious.
- Describe caveats.
- If using an external API generator (like go-doc, js-doc, or so on), point to an external `API.md` file. This can be the only item in the section, if present.

### Maintainer(s)
**Status**: Optional.

**Requirements:**
- Must be called `Maintainer` or `Maintainers`.
- List maintainer(s) for a repository, along with one way of contacting them (e.g. GitHub link or email).

**Suggestions:**
- This should be a small list of people in charge of the repo. This should not be everyone with access rights, such as an entire organization, but the people who should be pinged and who are in charge of the direction and maintenance of the repository.
- Listing past maintainers is good for attribution, and kind.

### Thanks
**Status**: Optional.

**Requirements:**
- Must be called `Thanks`, `Credits` or `Acknowledgements`.

**Suggestions:**
- State anyone or anything that significantly helped with the development of your project.
- State public contact hyper-links if applicable.

### Contributing
**Status**: Required.

**Requirements:**
- State where users can ask questions.
- State whether PRs are accepted.
- List any requirements for contributing; for instance, having a sign-off on commits.

**Suggestions:**
- Link to a CONTRIBUTING file -- if there is one.
- Be as friendly as possible.
- Link to the GitHub issues.
- Link to a Code of Conduct. A CoC is often in the Contributing section or document, or set elsewhere for an entire organization, so it may not be necessary to include the entire file in each repository. However, it is highly recommended to always link to the code, wherever it lives.
- A subsection for listing contributors is also welcome here.

### License
**Status:** Required.

**Requirements:**
- State license full name or identifier, as listed on the  [SPDX](https://spdx.org/licenses/) license list. For unlicensed repositories, add `UNLICENSED`. For more details, add `SEE LICENSE IN <filename>` and link to the license file. (These requirements were adapted from [npm](https://docs.npmjs.com/files/package.json#license)).
- State license owner.
- Must be last section.

**Suggestions:**
- Link to longer License file in local repository.

## Definitions

_These definitions are provided to clarify any terms used above._

- **Documentation repositories**: Repositories without any functional code. For instance, [RichardLitt/knowledge](https://github.com/RichardLitt/knowledge).