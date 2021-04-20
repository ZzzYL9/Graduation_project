function serialize(model) {
    var res = "{ \"TEXT\": [\n";

    console.log("count: " + model.count);

    for(var i = 0; i < model.count; ++i) {
        res += "\n{\t";
        var e = model.get(i);
        res += "\"number\": \""   +　i + "\",\n\t";
        res += "\"name\": \""   +　e.name + "\",\n\t";
        res += "\"password\": \""   +　e.password + "\",\n\t";
        res += "\"time\": \"" + e.time + "\"\n\t";
        //The last one should not have the ending ","
        if ( i === model.count -1)
            res += "\n}";
        else
            res += "\n},";
    }

    res += "\n]\n}";

    console.log("res: " + res );
    return res;
}
function setnote(model) {
    var res = "{ \"NOTE\": [\n";

    console.log("count: " + model.count);

    for(var i = 0; i < model.count; ++i) {
        res += "\n{\t";
        var e = model.get(i);
        res += "\"book\": \""   +　e.book + "\",\n\t";
        res += "\"users\": \""   +　e.users + "\",\n\t";
        res += "\"thetext\": \""   +　e.thetext + "\",\n\t";
        res += "\"thesource\": \""   +　e.thesource + "\",\n\t";
        res += "\"ty\": \""   +　e.ty + "\",\n\t";
        res += "\"num\": \""   +　e.num + "\",\n\t";
        res += "\"positionstart\": \""   +　e.positionstart + "\",\n\t";
        res += "\"positionend\": \""   +　e.positionend + "\",\n\t";
        res += "\"bookimage\": \""   +　e.bookimage + "\",\n\t";
        res += "\"ttxt\": \"" + e.ttxt + "\"\n\t";
        //The last one should not have the ending ","
        if ( i === model.count -1)
            res += "\n}";
        else
            res += "\n},";
    }

    res += "\n]\n}";

    console.log("res: " + res );
    return res;
}
