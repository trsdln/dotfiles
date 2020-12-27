res = [];
document.querySelectorAll('a.ytd-grid-video-renderer').forEach(i => res.push([i.innerText,i.href]));
res.map(([t,h]) =>`#EXTINF:, ${t}\n${h}`).join('\n');

res = [];
document.querySelectorAll('a.video').forEach(i => res.push([i.innerText,i.href]));
res.map(([t,h]) =>`#EXTINF:, ${t}\n${h}`).join('\n');
