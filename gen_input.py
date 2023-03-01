import numpy as np
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--n", type=int, default=10000)
    args = parser.parse_args()

    xs = np.random.randint(-1000, 1000, size=(args.n, 2), dtype=np.int64)
    xs.tofile("/dev/stdout")
    
