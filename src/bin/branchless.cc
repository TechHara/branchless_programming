#include <fstream>
#include <iostream>
#include <optional>
#include <vector>

using i64 = int64_t;

int main(int argc, const char **argv) {
  std::ifstream ifs{argc >= 2 ? argv[1] : "/dev/stdin"};
  std::string buf{std::istreambuf_iterator<char>{ifs},
                  std::istreambuf_iterator<char>{}};
  auto file_size = buf.size();

  std::vector<std::optional<i64>> xs, ys;
  xs.reserve(file_size / sizeof(i64) / 2);
  ys.reserve(file_size / sizeof(i64) / 2);
  for (std::size_t idx = 0; idx < file_size / sizeof(i64) / 2; ++idx) {
    auto val = reinterpret_cast<i64 const *>(buf.data())[idx];
    if (val >= 0)
      xs.emplace_back(val);
    else
      xs.emplace_back();
  }
  for (std::size_t idx = file_size / sizeof(i64) / 2;
       idx < file_size / sizeof(i64); ++idx) {
    auto val = reinterpret_cast<i64 const *>(buf.data())[idx];
    if (val >= 0)
      ys.emplace_back(val);
    else
      ys.emplace_back();
  }

  i64 result = 0;
  for (auto const &x : xs) {
    for (auto const &y : ys) {
      i64 branches[] = {-1, *x * *y};
      result += branches[bool(x) && bool(y)];
    }
  }

  std::cout << result << "\n";
  return 0;
}