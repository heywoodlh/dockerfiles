### Docker image for tools by [tomnomnom](https://github.com/tomnomnom)

This image was built with the intention to integrate with your shell as aliases for each tool.

I use Fish as my daily-driver shell, so I have only taken time and tested functions in Fish. The same functionality could be achieved with BASH scripts or aliases. 

## Fish Functions:

```
function assetfinder
  docker run --rm -i heywoodlh/tomnomnom-tools:latest assetfinder $argv
end

function gf
  docker run --rm -i heywoodlh/tomnomnom-tools:latest bash -c "cat | gf $argv"
end

function gron
  docker run --rm -i heywoodlh/tomnomnom-tools:latest bash -c "gron $argv"
end

function httprobe
  docker run --rm -i heywoodlh/tomnomnom-tools:latest bash -c "cat | httprobe $argv"
end

function meg
  if test -z $argv[1]; or test -z $argv[2]
    echo 'meg [path|pathsFile] [hostsFile] [outputDir]'
  else
    set pathsFile $argv[1]
    set hostsFile $argv[2]
    if test -z $argv[3]
      set outDir 'out'
      if test ! -f $outDir
        mkdir -p $outDir
      end
    else
      set outDir $argv[3]
    end
    if test -f $pathsFile
      docker run -v $pathsFile:/tmp/paths -v $hostsFile:/tmp/hosts -v $outDir:/tmp/outDir --rm -i heywoodlh/tomnomnom-tools:latest meg /tmp/paths /tmp/hosts /tmp/outDir $argv[4..20]
    else
      docker run -v $hostsFile:/tmp/hosts -v $outDir:/tmp/outDir --rm -i heywoodlh/tomnomnom-tools:latest meg $pathsFile /tmp/hosts /tmp/outDir $argv[4..20]
    end
  end
end

function unfurl
  docker run --rm -i heywoodlh/tomnomnom-tools:latest bash -c "cat | unfurl $argv"
end

function waybackurls
  docker run --rm -i heywoodlh/tomnomnom-tools:latest bash -c "cat | waybackurls $argv"
end
```

## Examples:

### [assetfinder](https://github.com/tomnomnom/assetfinder):

```
assetfinder example.com
```

### [gf](https://github.com/tomnomnom/gf):

```
echo '192.168.1.135' | gf ip
```

### [gron](https://github.com/tomnomnom/gron): 
```
gron "https://api.github.com/repos/tomnomnom/gron/commits?per_page=1"
```


### [httprobe](https://github.com/tomnomnom/httprobe):
```
cat domains.txt | httprobe
```


### [meg](https://github.com/tomnomnom/meg):
```
meg /robots.txt domains.txt outputDir

## OR 

meg pathsFile domains.txt outputDir
```


### [unfurl](https://github.com/tomnomnom/unfurl):
```
cat urls.txt | unfurl domains
```

### [waybackurls](https://github.com/tomnomnom/waybackurls):
```
cat domains.txt | waybackurls
```
