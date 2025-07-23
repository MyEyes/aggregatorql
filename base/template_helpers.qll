
bindingset[filepath, startline, endline]
string exportFileLines(string filepath, int startline, int endline)
{
    result = "{{ database.source_archive.read_location(\""+filepath+"\","+startline.toString()+","+endline.toString()+") }}"
}

bindingset[filepath]
string exportFileHash(string filepath)
{
    result = "{{ database.source_archive.get_file_hash(\"" + filepath + "\") }}"
}