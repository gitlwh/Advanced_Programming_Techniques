/*
// Weiheng Li
// wel615
// CSE 411
*/
import scala.io.Source.fromFile
import scala.collection.immutable.ListMap

object Proj4{
    def main(args: Array[String]){
        val lines = scala.io.Source.fromFile("top40.sql").getLines.toList
        val linesInfo = lines.map(line => songInfo(line))
        //1
        val trivial = List("","DO", "A", "IN", "THAT", "FOR", "NOT", "TO", "ON", "WITH", "HE", "AS", "YOU", "HAVE", "IT", "AT", "THE", "BE", "OF", "I", "AND").toSet
        val summary = linesInfo.map(lineInfo => lineInfo._2).flatten.filterNot(trivial).groupBy(word => word).map(map => (map._1, map._2.length))
        val topFiveWords = ListMap(summary.toSeq.sortBy(_._2).reverse:_*).slice(0,10);
        //2a
        val artists = linesInfo.map(lineInfo => lineInfo._1).groupBy(artist => artist).map(map => (map._1, map._2.length))
        val sortedArtist = ListMap(artists.toSeq.sortBy(_._2).reverse:_*)
        val topFiveArtist = sortedArtist.slice(0, 10);
        //2b
        val No1Artist = linesInfo.map(lineInfo => if(lineInfo._3 == 1) lineInfo._1 else "").toList.filterNot(Set(""))
        val No1ArtistNumber = No1Artist.length
        val No1ArtistNumberMap = No1Artist.groupBy(artist => artist).map(map => (map._1, map._2.length))
        val sortedNo1ArtistNumber = ListMap(No1ArtistNumberMap.toSeq.sortBy(_._2).reverse:_*)
        val topFiveOneArtist = sortedNo1ArtistNumber.slice(0,10);
        //3
        //Love
        val loveNumber = linesInfo.map(lineInfo => if(lineInfo._2.contains("LOVE")) lineInfo._1 else "").toList.filterNot(Set("")).length
        val loveNo1Number = linesInfo.map(lineInfo => if(lineInfo._2.contains("LOVE")&&(lineInfo._3 == 1)) lineInfo._1 else "").toList.filterNot(Set("")).length
        //ME
        val meNumber = linesInfo.map(lineInfo => if(lineInfo._2.contains("ME")) lineInfo._1 else "").toList.filterNot(Set("")).length
        val meNo1Number = linesInfo.map(lineInfo => if(lineInfo._2.contains("ME")&&(lineInfo._3 == 1)) lineInfo._1 else "").toList.filterNot(Set("")).length
        

        println("Top ten most popular words:")
        topFiveWords.foreach(x => println(x._1 + "\t" + x._2))
        println("Top ten artist with most songs in top 40:")
        topFiveArtist.foreach(x => println(x._1 + "\t" + x._2))
        print("Top 10 artist with most number 1 song: \n")
        topFiveOneArtist.foreach(x => println(x._1 + "\t" + x._2))
        println("P(LOVE|#1): " + loveNo1Number / No1ArtistNumber.toDouble)
        println("P(ME|#1): " + meNo1Number / No1ArtistNumber.toDouble)
        println("P(#1|LOVE): " + loveNo1Number / loveNumber.toDouble)
        println("P(#1|ME): " + meNo1Number / meNumber.toDouble)
    }
    def songInfo(j:String):(String,List[String],Int)={
        val sep = j.split("'")
        val words = sep(3).split("[ ),!./(]").toList
        val info = (sep(1),words,sep(4).charAt(2)-'0')
        info
    }
}