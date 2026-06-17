// Define your exported module types here.
export type CounterModuleEvents = {
  onCountChange: (params: { count: number }) => void;
};