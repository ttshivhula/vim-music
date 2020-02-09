function! Trim_whitespace(target)
	let target = substitute(a:target, "^\\s\\+\\|\\s\\+$", "", "g")
	let target = substitute(target, "^\\n\\+\\|\\n\\+$", "", "g")
	return target
endfunction

function! CMUSGetSongInfo()
	let artist = system('cmus-remote -Q | grep "tag artist " | cut -d " " -f 3-')
	let album = system('cmus-remote -Q | grep "tag album " | cut -d " " -f 3-')
	let song = system('cmus-remote -Q | grep "tag title " | cut -d " " -f 3-')
	let file = system('cmus-remote -Q | grep "file " | cut -d " " -f 2-')

	let artist = Trim_whitespace(artist)
	let album = Trim_whitespace(album)
	let song = Trim_whitespace(song)
	let file = Trim_whitespace(file)

	return artist . " - " . album . " - " . song . " file: " . file
endfunction

function! CMUSPause()
	let result = system('cmus-remote --pause')
	echo "Pausing/resuming " . CMUSGetSongInfo()
endfunction

function! CMUSStop()
	let result = system('cmus-remote --stop')
	echo CMUSGetSongInfo()
endfunction

function! CMUSPlay()
	let result = system('cmus-remote --play')
	echo "Playing " . CMUSGetSongInfo()
endfunction

function! CMUSNext()
	let result = system('cmus-remote --next')
	echo "Playing " . CMUSGetSongInfo()
endfunction

function! CMUSPrevious()
	let result = system('cmus-remote --prev')
	echo "Playing " . CMUSGetSongInfo()
endfunction

function! CMUSCurrent()
	echo CMUSGetSongInfo()
endfunction

function! RepeatInfo()
	let repeat = system('cmus-remote -Q | grep "set repeat_current " | cut -d " " -f 3-')
	return Trim_whitespace(repeat)
endfunction

function! CMUSToggleRepeat()
	let result = system('cmus-remote -C "toggle repeat_current"')
	echo "Song Repeat - " . RepeatInfo()
endfunction
