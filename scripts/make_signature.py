import re
import sys
method_signature_strs = [s.strip() +";" for s in """int ( *get_size)(const avro_value_iface_t *iface,
            const void *self, size_t *size);
 int ( *get_by_index)(const avro_value_iface_t *iface,
                const void *self, size_t index,
                avro_value_t *child, const char **name);

    int ( *get_by_name)(const avro_value_iface_t *iface,
               const void *self, const char *name,
               avro_value_t *child, size_t *index);

    int ( *get_discriminant)(const avro_value_iface_t *iface,
                const void *self, int *out);
    int ( *get_current_branch)(const avro_value_iface_t *iface,
                  const void *self, avro_value_t *branch);

    int ( *append)(const avro_value_iface_t *iface,
              void *self, avro_value_t *child_out, size_t *new_index);

    int ( *add)(const avro_value_iface_t *iface,
           void *self, const char *key,
           avro_value_t *child, size_t *index, int *is_new);

    int ( *set_branch)(const avro_value_iface_t *iface,
              void *self, int discriminant,
              avro_value_t *branch)""".split(";")]






def extract_function_ptr_signature(method_signature_str):
    r = re.compile(r"(\w+)\s*[(]\s*[*](\w+)\s*[)][(]([^)]+)[)];")
    m = r.match(method_signature_str)
    return_type = m.group(1)
    func_ptr_name = m.group(2)
    param_list = m.group(3).split(",")


    parameter_re = re.compile(r"(const\s+)?(\w+)\s+([*]?)(\w+)")
    def get_parameter_type(param_str):
        m = parameter_re.search(param_str)
        parameter_type = m.group(2)
        if m.group(3) is None:
            return parameter_type
        else:
            return "ptr %s" % parameter_type

    return (return_type, func_ptr_name, [get_parameter_type(p) for p in param_list])


def make_field_function_ptr(struct_name, method_signature):
    (return_type, func_ptr_name, param_types) = method_signature
    params_str = " @-> ".join(param_types)
    template = """
    let %s_%s =
        field %s "%s"
        (funptr (%s @-> returning %s))"""
    return template % (struct_name, func_ptr_name, struct_name, func_ptr_name, 
            params_str, return_type) 

for method_signature_str in method_signature_strs:
    print make_field_function_ptr("avro_value_iface", extract_function_ptr_signature(method_signature_str))


def main():
    struct_name = sys.argv[1]
    method_signature_str = sys.stdin.read()
    method_signature = extract_function_ptr_signature(method_signature_str)
    field_definition = make_field_function_ptr(struct_name, method_signature)
    print field_definition

# if __name__ == "__main__":
#     main()
