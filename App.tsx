import { StatusBar } from 'expo-status-bar';
import { useEffect, useState } from 'react';
import { StyleSheet, Text, View, Pressable } from 'react-native';
import CounterModule from './modules/counter/src/CounterModule';

export default function App() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    setCount(CounterModule.getCount());

    const subscription = CounterModule.addListener(
      'onCountChange',
      (payload) => {
        setCount(payload.count);
      }
    );

    return () => subscription.remove();
  }, []);

  const increment = () => CounterModule.setCount(count + 1);
  const decrement = () => CounterModule.setCount(count - 1);

  return (
    <View style={styles.container}>
      <Text style={styles.label}>Counter</Text>
      <Text style={styles.count}>{count}</Text>

      <View style={styles.buttonRow}>
        <Pressable style={styles.button} onPress={decrement}>
          <Text style={styles.buttonText}>−</Text>
        </Pressable>

        <Pressable style={styles.button} onPress={increment}>
          <Text style={styles.buttonText}>+</Text>
        </Pressable>
      </View>

      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  label: {
    fontSize: 18,
    color: '#888',
    marginBottom: 8,
  },
  count: {
    fontSize: 64,
    fontWeight: 'bold',
    marginBottom: 32,
  },
  buttonRow: {
    flexDirection: 'row',
    gap: 24,
  },
  button: {
    width: 64,
    height: 64,
    borderRadius: 32,
    backgroundColor: '#007AFF',
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 32,
    fontWeight: 'bold',
  },
});