# 출처: https://docs.confluent.io/clients-confluent-kafka-python/current/overview.html
# 테스트해볼자료: https://data-newbie.tistory.com/252

# Kafka Producer
from confluent_kafka import Producer
import socket

conf = {'bootstrap.servers': "localhost:9092,localhost:9093,localhost:9094",
        'client.id': socket.gethostname()}

producer = Producer(conf)
producer.produce("my-first-topic", key="key", value="value")
producer.flush()

# Kafka Consumer
from confluent_kafka import Consumer

conf = {'bootstrap.servers': "localhost:9092,localhost:9093,localhost:9094",
        'group.id': "foo",
        'auto.offset.reset': 'smallest'}

consumer = Consumer(conf)

running = True

def basic_consume_loop(consumer, topics):
    try:
        consumer.subscribe(topics)

        while running:
            msg = consumer.poll(timeout=1.0)
            if msg is None: continue

            if msg.error():
                if msg.error().code() == KafkaError._PARTITION_EOF:
                    # End of partition event
                    sys.stderr.write('%% %s [%d] reached end at offset %d\n' %
                                     (msg.topic(), msg.partition(), msg.offset()))
                elif msg.error():
                    raise KafkaException(msg.error())
            else:
                msg_process(msg)
    finally:
        # Close down consumer to commit final offsets.
        consumer.close()

def shutdown():
    running = False