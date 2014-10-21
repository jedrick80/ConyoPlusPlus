java -jar java-cup-11b.jar -interface -parser Parser conyo.cup
javac -cp java-cup-11b-runtime.jar;. *.java
java -cp java-cup-11b-runtime.jar;. ConyoLexer test.txt > output.txt