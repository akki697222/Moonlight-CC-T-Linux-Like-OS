local cDir = shell.dir()
function wget(url) 
    shell.run("wget "..url)
end
print("Installing Advanced Commands...")
shell.run("mkdir /moonlight/tmp/cmdinstaller_tmp")
shell.run("cd /moonlight/tmp/cmdinstaller_tmp")
wget()
shell.run("cp /moonlight/tmp/cmdinstaller_tmp /moonlight/bin")
