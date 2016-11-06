import nltk
import os
import pdb

def run(text):
    tokens = nltk.word_tokenize(text)
    p = nltk.PorterStemmer()
    tag = nltk.pos_tag(tokens)
    ret = "["
    for i in range(0, len(tag)):
        string, t = tag[i]
        t = t[0]
        string = p.stem(string)
        if (not(string == "." or t == ".")):
                ret += ("[" + string.lower() + "," + t.lower() + "], ")
    ret = ret[0:len(ret) - 2]
    ret += "]"
    write(ret)

def write(text):
    f = open('run.pl', 'w')
    f.write("#include 'rules.pl'.\n")
    f.write("\n")
    f.write("#compute 0 { _run(" + text + ", " + context() + ", X) }.")
    f.close()
    run_sasp()

def run_sasp():
    os.system("sasp run.pl")

def context():
    return "united_states, man"

if __name__ == "__main__":
    string = raw_input("Enter input: ")
    run(string)
