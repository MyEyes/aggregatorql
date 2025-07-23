import cpp

string exportLocation(Location loc)
{
    result = loc.getFile().getRelativePath()+":"+loc.getStartLine()+":"+loc.getEndLine()
}