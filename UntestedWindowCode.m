% note: none of this is actually tested yet



%code for creating a trailing 2 second window
window = 2000; % window time in ms
currentIndex = t(length(t))
currentTime = currentIndex;
twoSecondsAgo = currentTime-2000;
indexTwoSecondsAgo = find(t=twoSecondsAgo);
axWindow = ax(indexTwoSecondsAgo:currentIndex);
ayWindow = ay(indexTwoSecondsAgo:currentIndex);
azWindow = az(indexTwoSecondsAgo:currentIndex);

