import cpp
import base.template_helpers

string exportLocation(Location loc)
{
    result = "```c\\n"+exportFileLines(loc.getFile().getAbsolutePath(), loc.getStartLine(), loc.getEndLine())+"\\n```"
}

string fileHash(File file)
{
    result = exportFileHash(file.getAbsolutePath())
}