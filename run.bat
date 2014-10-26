java jflex.Main conyo.flex
java -jar java-cup-11b.jar -interface -parser Parser conyo.cup
javac -cp java-cup-11b-runtime.jar;. *.java
java -cp java-cup-11b-runtime.jar;. MainConyo test1.txt > output1.txt
java -cp java-cup-11b-runtime.jar;. MainConyo test2.txt > output2.txt
java -cp java-cup-11b-runtime.jar;. MainConyo test3.txt > output3.txt