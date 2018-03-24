## Docker
Per buildare docker:
```
./script/build.sh
```

Per avviare docker:
```
./script/hadoop.sh
```

## Java
```
mvn install
```

## Hadoop & HDFS
Crea una cartella nell'hdfs
```
hdfs dfs -mkdir /user/root/input
```

Copia da locale a hdfs
```
hadoop fs -copyFromLocal divina.txt /user/root/input
```

Mostra i file in una cartella
```
hdfs dfs -ls /user/root/input
```

Copia i dati dall'hdfs in locale:
```
hadoop fs -copyToLocal /user/root/output/* /jobs/
```

Per avviare il progetto.
p.s. input_folder e output_folder devono stare dentro /user/root
```
hadoop jar wordcount.jar "input_folder" "output_folder"
```