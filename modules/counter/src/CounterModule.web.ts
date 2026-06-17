import { registerWebModule, NativeModule } from 'expo';

class CounterModule extends NativeModule<{}> {}

export default registerWebModule(CounterModule, 'CounterModule');
