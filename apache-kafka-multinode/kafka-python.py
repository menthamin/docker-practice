from kafka import KafkaProducer

producer = KafkaProducer(bootstrap_servers="localhost:9092")
future = producer.send('foobar', b'another_message')

for _ in range(100):
    producer.send("foobar", b"some_message_bytes")
    
  
# manually assign the partition list for the consumer
from kafka import KafkaConsumer
from kafka import TopicPartition
consumer = KafkaConsumer(bootstrap_servers='localhost:9092')
consumer.assign([TopicPartition('foobar', 2)])
msg = next(consumer)  
# from kafka import KafkaConsumer
# consumer = KafkaConsumer('my_favorite_topic')
# for msg in consumer:
#    print (msg)