### License

All work in this repository is published under the MIT license.
Please refer to the LICENSE file for detailed information.

### cdbm.sh

#### Installation

Download the file and copy it into your user's home directory.
Then source it in your `.bashrc` file to load the contained functions:

```bash
source cdbm.sh
```

#### Usage

To set a bookmark, use:

```bash
mkbm name /some/long/path/to/bookmark
```

To change directory to a bookmark:

```bash
cdbm name
```

To delete an existing bookmark:

```bash
rmbm name
```

To print all existing bookmarks (along with a primitive help message):

```bash
cdbm
```
