use core::{mem, slice};
use std::env;
use std::fs::File;
use std::io::Read;

fn main() -> std::io::Result<()> {
    let args: Vec<_> = env::args().collect();
    let mut input_file = File::open(if args.len() >= 2 {
        args[1].to_owned()
    } else {
        "/dev/stdin".to_owned()
    })?;

    let mut buf = Vec::new();
    let read_size = input_file.read_to_end(&mut buf)?;
    let temp_vec = unsafe {
        slice::from_raw_parts(
            buf.as_ptr() as *const i64,
            read_size / mem::size_of::<i64>(),
        )
    };
    let xs: Vec<_> = temp_vec[..temp_vec.len() / 2]
        .iter()
        .map(|val| if *val >= 0 { Some(*val) } else { None })
        .collect();
    let ys: Vec<_> = temp_vec[temp_vec.len() / 2..]
        .iter()
        .map(|val| if *val >= 0 { Some(*val) } else { None })
        .collect();

    let mut result = 0i64;
    for x in &xs {
        for y in &ys {
            let branches = [-1, unsafe { x.unwrap_unchecked() * y.unwrap_unchecked() }];
            result += branches[(x.is_some() && y.is_some()) as usize];
        }
    }

    println!("{result}");
    Ok(())
}
