## Docker
Per buildare docker:
```
./scripts/build.sh
```

Per avviare docker:
```
./scripts/hadoop.sh
```

La macchina host e docker condividono la cartella jobs. Quindi se devi copiare file nell'hdfs conviene prima metterli 
nella cartella jobs e successivamente dalla shell di docker caricarli sull'hdfs (vedi sotto come).

## Java
Per buildare i jobs:
```
mvn install && mv target/*.jar jobs/
```

## Hadoop & HDFS
Crea una cartella nell'hdfs:
```
hdfs dfs -mkdir /user/root/input
```

Copia da locale a hdfs:
```
hadoop fs -copyFromLocal divina.txt /user/root/input
```

Mostra i file in una cartella:
```
hdfs dfs -ls /user/root/input
```

Copia i dati dall'hdfs in locale:
```
hadoop fs -copyToLocal /user/root/output/* /jobs/
```

Per avviare il progetto.
p.s. input_folder e output_folder devono stare dentro /user/root:
```
hadoop jar wordcount.jar "input_folder" "output_folder"
```
