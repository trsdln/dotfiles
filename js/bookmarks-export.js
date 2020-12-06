/**
 * Exports from html to bm friendly format
 */
function _exportBookmarks() {
  function parseLink(linkCont) {
    const link = linkCont.querySelector('a');
    return {name: link.text, url: link.getAttribute('href')};
  }

  function parseDirectory(dirRoot) {
    const dirName = dirRoot.querySelector('h3').textContent;
    const dirContent = dirRoot.querySelector('dl').children;
    const dirItems = [];
    for (item of dirContent) {
      if(item.tagName !== "P") {
        const nestedDirName = item.querySelector('h3');
        if(nestedDirName) {
          dirItems.push(parseDirectory(item));
        }else{
          dirItems.push(parseLink(item));
        }
      }
    }
    return {name: dirName, items: dirItems};
  }
  const root = document.querySelector('dt');
  const parsedConts = parseDirectory(root);

  function serializeBookmarksObj(obj, parentPath = []) {
    if(obj.url) {
      return `${[...parentPath, obj.name].join('/')}*${obj.url}`;
    }
    return obj.items.map(item => serializeBookmarksObj(item, [...parentPath, obj.name])).join('\n');
  }

  const expRes = parsedConts.items.map(subItem => serializeBookmarksObj(subItem)).join('\n');
  console.log(expRes);
}
_exportBookmarks();

