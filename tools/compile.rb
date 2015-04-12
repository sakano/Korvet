require "Find"
require "optparse"

Dir.chdir(File.expand_path(File.dirname($0)))

TVPPath = File.absolute_path("../tvpwin32.exe")
PreprocessFile = File.absolute_path("./include/preprocessSetting.tjs")
IncludePath = File.absolute_path("include/")
SrcPath = File.absolute_path("../src/") + "/"
DebugPath = File.absolute_path("../data/debug/") + "/"
ReleaseIntermeditatePath = File.absolute_path("../data/release_intermediate/") + "/"
ReleasePath = File.absolute_path("../data/release/") + "/"
CompileScriptPath = File.absolute_path("compile_tjs.tjs")
CompileScriptDir = File.dirname(CompileScriptPath)
CompileTime = Time.now.to_s

# Delete all files in the directory
def clean(dir)
    Find.find(dir){|f|
        next unless FileTest.file?(f)
        if File.basename(f) != ".gitkeep"
            File.delete(f)
        end
    }
end

preprocess = lambda {|f, df, param|
    # Do preprocess
    cmd = "m4 -E -P #{param} -I\"#{File.dirname f}\" -I\"#{IncludePath}\" \"#{PreprocessFile}\" \"#{f}\""
    puts cmd
    result = `#{cmd}`
    
    # Error check
    if $? != 0
        return false
    end
    result = result.encode("utf-8","utf-8")
    if File.exist?("#{df}") then File.chmod(0666, "#{df}") end
    File.write("#{df}", result)
    File.chmod(0444, "#{df}")
    
    return true
}

compile = lambda{|f, df, param|
    # Do compile
    cmd = "#{TVPPath} \"#{CompileScriptDir}\" -startup=\"#{CompileScriptPath}\" -src=\"#{f}\" -dest=\"#{df}\" -type=\"script\" #{param}"
    puts cmd
    if File.exist?("#{df}") then File.chmod(0666, "#{df}") end
    puts `#{cmd}`
    File.chmod(0444, "#{df}")
    
    # Error check
    if $? != 0
        return false
    end
    
    return true
}

def do_all_files(dest, src, param, label, &do_cmd)
    success = true
    Find.find(src){|f|
        next unless FileTest.file?(f)
        next if File.basename(f)[0] == "."
        f = File.absolute_path(f) # the source file's path
        df = "#{dest}#{File.basename f}" # the dest file's path
        
        puts " == #{label}(#{f}) =="
        
        # Skip the file if update time is same,
        src_time = File.mtime(f)
        if File.exist?(df)
            dest_time = File.mtime(df)
            if src_time == dest_time
                puts "skip"
                next
            end
        end
        
        # Do command
        if !do_cmd.call(f, df, param)
            puts " == #{label} ERROR =="
            success = false
            return
        end
        
        # Change update time
        File.utime(src_time, src_time, "#{df}")
    }
    return success
end

args = ARGV.getopts("", "clean", "debug", "release")

if args["debug"]
    if args["clean"]
        clean(DebugPath)
    end
    do_all_files(DebugPath, SrcPath, "-DDEBUG=1 -DRELEASE=0 -Dm4___time__=\"#{CompileTime}\"", "PREPROCESS", &preprocess)
end
if args["release"]
    if args["clean"]
        clean(ReleaseIntermeditatePath)
        clean(ReleasePath)
    end
    if do_all_files(ReleaseIntermeditatePath, SrcPath, "-DDEBUG=0 -DRELEASE=1 -Dm4___time__=\"#{CompileTime}\"", "PREPROCESS", &preprocess)
        do_all_files(ReleasePath, ReleaseIntermeditatePath, "", "COMPILE", &compile)
    end
end
