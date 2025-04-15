module CtlPath(
  output        io_dmem_req_valid,
  output        io_dmem_req_bits_fcn,
  output [2:0]  io_dmem_req_bits_typ,
  input         io_dmem_resp_valid,
  input  [31:0] io_dat_inst,
  input         io_dat_br_eq,
  input         io_dat_br_lt,
  input         io_dat_br_ltu,
  input         io_dat_csr_eret,
  output        io_ctl_stall,
  output [2:0]  io_ctl_pc_sel,
  output [1:0]  io_ctl_op1_sel,
  output [1:0]  io_ctl_op2_sel,
  output [3:0]  io_ctl_alu_fun,
  output [1:0]  io_ctl_wb_sel,
  output        io_ctl_rf_wen,
  output [2:0]  io_ctl_csr_cmd,
  output        io_ctl_exception
);
  wire [31:0] _T = io_dat_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _T_1 = 32'h2003 == _T; // @[Lookup.scala 31:38]
  wire  _T_3 = 32'h3 == _T; // @[Lookup.scala 31:38]
  wire  _T_5 = 32'h4003 == _T; // @[Lookup.scala 31:38]
  wire  _T_7 = 32'h1003 == _T; // @[Lookup.scala 31:38]
  wire  _T_9 = 32'h5003 == _T; // @[Lookup.scala 31:38]
  wire  _T_11 = 32'h2023 == _T; // @[Lookup.scala 31:38]
  wire  _T_13 = 32'h23 == _T; // @[Lookup.scala 31:38]
  wire  _T_15 = 32'h1023 == _T; // @[Lookup.scala 31:38]
  wire [31:0] _T_16 = io_dat_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _T_17 = 32'h17 == _T_16; // @[Lookup.scala 31:38]
  wire  _T_19 = 32'h37 == _T_16; // @[Lookup.scala 31:38]
  wire  _T_21 = 32'h13 == _T; // @[Lookup.scala 31:38]
  wire  _T_23 = 32'h7013 == _T; // @[Lookup.scala 31:38]
  wire  _T_25 = 32'h6013 == _T; // @[Lookup.scala 31:38]
  wire  _T_27 = 32'h4013 == _T; // @[Lookup.scala 31:38]
  wire  _T_29 = 32'h2013 == _T; // @[Lookup.scala 31:38]
  wire  _T_31 = 32'h3013 == _T; // @[Lookup.scala 31:38]
  wire [31:0] _T_32 = io_dat_inst & 32'hfc00707f; // @[Lookup.scala 31:38]
  wire  _T_33 = 32'h1013 == _T_32; // @[Lookup.scala 31:38]
  wire  _T_35 = 32'h40005013 == _T_32; // @[Lookup.scala 31:38]
  wire  _T_37 = 32'h5013 == _T_32; // @[Lookup.scala 31:38]
  wire [31:0] _T_38 = io_dat_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _T_39 = 32'h1033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_41 = 32'h33 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_43 = 32'h40000033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_45 = 32'h2033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_47 = 32'h3033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_49 = 32'h7033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_51 = 32'h6033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_53 = 32'h4033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_55 = 32'h40005033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_57 = 32'h5033 == _T_38; // @[Lookup.scala 31:38]
  wire  _T_59 = 32'h6f == _T_16; // @[Lookup.scala 31:38]
  wire  _T_61 = 32'h67 == _T; // @[Lookup.scala 31:38]
  wire  _T_63 = 32'h63 == _T; // @[Lookup.scala 31:38]
  wire  _T_65 = 32'h1063 == _T; // @[Lookup.scala 31:38]
  wire  _T_67 = 32'h5063 == _T; // @[Lookup.scala 31:38]
  wire  _T_69 = 32'h7063 == _T; // @[Lookup.scala 31:38]
  wire  _T_71 = 32'h4063 == _T; // @[Lookup.scala 31:38]
  wire  _T_73 = 32'h6063 == _T; // @[Lookup.scala 31:38]
  wire  _T_75 = 32'h5073 == _T; // @[Lookup.scala 31:38]
  wire  _T_77 = 32'h6073 == _T; // @[Lookup.scala 31:38]
  wire  _T_79 = 32'h7073 == _T; // @[Lookup.scala 31:38]
  wire  _T_81 = 32'h1073 == _T; // @[Lookup.scala 31:38]
  wire  _T_83 = 32'h2073 == _T; // @[Lookup.scala 31:38]
  wire  _T_85 = 32'h3073 == _T; // @[Lookup.scala 31:38]
  wire  _T_87 = 32'h73 == io_dat_inst; // @[Lookup.scala 31:38]
  wire  _T_89 = 32'h30200073 == io_dat_inst; // @[Lookup.scala 31:38]
  wire  _T_91 = 32'h7b200073 == io_dat_inst; // @[Lookup.scala 31:38]
  wire  _T_93 = 32'h100073 == io_dat_inst; // @[Lookup.scala 31:38]
  wire  _T_95 = 32'h10500073 == io_dat_inst; // @[Lookup.scala 31:38]
  wire  _T_97 = 32'h100f == _T; // @[Lookup.scala 31:38]
  wire  _T_99 = 32'hf == _T; // @[Lookup.scala 31:38]
  wire  _T_130 = _T_39 | (_T_41 | (_T_43 | (_T_45 | (_T_47 | (_T_49 | (_T_51 | (_T_53 | (_T_55 | (_T_57 | (_T_59 | (
    _T_61 | (_T_63 | (_T_65 | (_T_67 | (_T_69 | (_T_71 | (_T_73 | (_T_75 | (_T_77 | (_T_79 | (_T_81 | (_T_83 | (_T_85 |
    (_T_87 | (_T_89 | (_T_91 | (_T_93 | (_T_95 | (_T_97 | _T_99))))))))))))))))))))))))))))); // @[Lookup.scala 33:37]
  wire  cs_val_inst = _T_1 | (_T_3 | (_T_5 | (_T_7 | (_T_9 | (_T_11 | (_T_13 | (_T_15 | (_T_17 | (_T_19 | (_T_21 | (
    _T_23 | (_T_25 | (_T_27 | (_T_29 | (_T_31 | (_T_33 | (_T_35 | (_T_37 | _T_130)))))))))))))))))); // @[Lookup.scala 33:37]
  wire [3:0] _T_162 = _T_73 ? 4'h6 : 4'h0; // @[Lookup.scala 33:37]
  wire [3:0] _T_163 = _T_71 ? 4'h5 : _T_162; // @[Lookup.scala 33:37]
  wire [3:0] _T_164 = _T_69 ? 4'h4 : _T_163; // @[Lookup.scala 33:37]
  wire [3:0] _T_165 = _T_67 ? 4'h3 : _T_164; // @[Lookup.scala 33:37]
  wire [3:0] _T_166 = _T_65 ? 4'h1 : _T_165; // @[Lookup.scala 33:37]
  wire [3:0] _T_167 = _T_63 ? 4'h2 : _T_166; // @[Lookup.scala 33:37]
  wire [3:0] _T_168 = _T_61 ? 4'h8 : _T_167; // @[Lookup.scala 33:37]
  wire [3:0] _T_169 = _T_59 ? 4'h7 : _T_168; // @[Lookup.scala 33:37]
  wire [3:0] _T_170 = _T_57 ? 4'h0 : _T_169; // @[Lookup.scala 33:37]
  wire [3:0] _T_171 = _T_55 ? 4'h0 : _T_170; // @[Lookup.scala 33:37]
  wire [3:0] _T_172 = _T_53 ? 4'h0 : _T_171; // @[Lookup.scala 33:37]
  wire [3:0] _T_173 = _T_51 ? 4'h0 : _T_172; // @[Lookup.scala 33:37]
  wire [3:0] _T_174 = _T_49 ? 4'h0 : _T_173; // @[Lookup.scala 33:37]
  wire [3:0] _T_175 = _T_47 ? 4'h0 : _T_174; // @[Lookup.scala 33:37]
  wire [3:0] _T_176 = _T_45 ? 4'h0 : _T_175; // @[Lookup.scala 33:37]
  wire [3:0] _T_177 = _T_43 ? 4'h0 : _T_176; // @[Lookup.scala 33:37]
  wire [3:0] _T_178 = _T_41 ? 4'h0 : _T_177; // @[Lookup.scala 33:37]
  wire [3:0] _T_179 = _T_39 ? 4'h0 : _T_178; // @[Lookup.scala 33:37]
  wire [3:0] _T_180 = _T_37 ? 4'h0 : _T_179; // @[Lookup.scala 33:37]
  wire [3:0] _T_181 = _T_35 ? 4'h0 : _T_180; // @[Lookup.scala 33:37]
  wire [3:0] _T_182 = _T_33 ? 4'h0 : _T_181; // @[Lookup.scala 33:37]
  wire [3:0] _T_183 = _T_31 ? 4'h0 : _T_182; // @[Lookup.scala 33:37]
  wire [3:0] _T_184 = _T_29 ? 4'h0 : _T_183; // @[Lookup.scala 33:37]
  wire [3:0] _T_185 = _T_27 ? 4'h0 : _T_184; // @[Lookup.scala 33:37]
  wire [3:0] _T_186 = _T_25 ? 4'h0 : _T_185; // @[Lookup.scala 33:37]
  wire [3:0] _T_187 = _T_23 ? 4'h0 : _T_186; // @[Lookup.scala 33:37]
  wire [3:0] _T_188 = _T_21 ? 4'h0 : _T_187; // @[Lookup.scala 33:37]
  wire [3:0] _T_189 = _T_19 ? 4'h0 : _T_188; // @[Lookup.scala 33:37]
  wire [3:0] _T_190 = _T_17 ? 4'h0 : _T_189; // @[Lookup.scala 33:37]
  wire [3:0] _T_191 = _T_15 ? 4'h0 : _T_190; // @[Lookup.scala 33:37]
  wire [3:0] _T_192 = _T_13 ? 4'h0 : _T_191; // @[Lookup.scala 33:37]
  wire [3:0] _T_193 = _T_11 ? 4'h0 : _T_192; // @[Lookup.scala 33:37]
  wire [3:0] _T_194 = _T_9 ? 4'h0 : _T_193; // @[Lookup.scala 33:37]
  wire [3:0] _T_195 = _T_7 ? 4'h0 : _T_194; // @[Lookup.scala 33:37]
  wire [3:0] _T_196 = _T_5 ? 4'h0 : _T_195; // @[Lookup.scala 33:37]
  wire [3:0] _T_197 = _T_3 ? 4'h0 : _T_196; // @[Lookup.scala 33:37]
  wire [3:0] cs_br_type = _T_1 ? 4'h0 : _T_197; // @[Lookup.scala 33:37]
  wire [1:0] _T_208 = _T_79 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _T_209 = _T_77 ? 2'h2 : _T_208; // @[Lookup.scala 33:37]
  wire [1:0] _T_210 = _T_75 ? 2'h2 : _T_209; // @[Lookup.scala 33:37]
  wire [1:0] _T_211 = _T_73 ? 2'h0 : _T_210; // @[Lookup.scala 33:37]
  wire [1:0] _T_212 = _T_71 ? 2'h0 : _T_211; // @[Lookup.scala 33:37]
  wire [1:0] _T_213 = _T_69 ? 2'h0 : _T_212; // @[Lookup.scala 33:37]
  wire [1:0] _T_214 = _T_67 ? 2'h0 : _T_213; // @[Lookup.scala 33:37]
  wire [1:0] _T_215 = _T_65 ? 2'h0 : _T_214; // @[Lookup.scala 33:37]
  wire [1:0] _T_216 = _T_63 ? 2'h0 : _T_215; // @[Lookup.scala 33:37]
  wire [1:0] _T_217 = _T_61 ? 2'h0 : _T_216; // @[Lookup.scala 33:37]
  wire [1:0] _T_218 = _T_59 ? 2'h0 : _T_217; // @[Lookup.scala 33:37]
  wire [1:0] _T_219 = _T_57 ? 2'h0 : _T_218; // @[Lookup.scala 33:37]
  wire [1:0] _T_220 = _T_55 ? 2'h0 : _T_219; // @[Lookup.scala 33:37]
  wire [1:0] _T_221 = _T_53 ? 2'h0 : _T_220; // @[Lookup.scala 33:37]
  wire [1:0] _T_222 = _T_51 ? 2'h0 : _T_221; // @[Lookup.scala 33:37]
  wire [1:0] _T_223 = _T_49 ? 2'h0 : _T_222; // @[Lookup.scala 33:37]
  wire [1:0] _T_224 = _T_47 ? 2'h0 : _T_223; // @[Lookup.scala 33:37]
  wire [1:0] _T_225 = _T_45 ? 2'h0 : _T_224; // @[Lookup.scala 33:37]
  wire [1:0] _T_226 = _T_43 ? 2'h0 : _T_225; // @[Lookup.scala 33:37]
  wire [1:0] _T_227 = _T_41 ? 2'h0 : _T_226; // @[Lookup.scala 33:37]
  wire [1:0] _T_228 = _T_39 ? 2'h0 : _T_227; // @[Lookup.scala 33:37]
  wire [1:0] _T_229 = _T_37 ? 2'h0 : _T_228; // @[Lookup.scala 33:37]
  wire [1:0] _T_230 = _T_35 ? 2'h0 : _T_229; // @[Lookup.scala 33:37]
  wire [1:0] _T_231 = _T_33 ? 2'h0 : _T_230; // @[Lookup.scala 33:37]
  wire [1:0] _T_232 = _T_31 ? 2'h0 : _T_231; // @[Lookup.scala 33:37]
  wire [1:0] _T_233 = _T_29 ? 2'h0 : _T_232; // @[Lookup.scala 33:37]
  wire [1:0] _T_234 = _T_27 ? 2'h0 : _T_233; // @[Lookup.scala 33:37]
  wire [1:0] _T_235 = _T_25 ? 2'h0 : _T_234; // @[Lookup.scala 33:37]
  wire [1:0] _T_236 = _T_23 ? 2'h0 : _T_235; // @[Lookup.scala 33:37]
  wire [1:0] _T_237 = _T_21 ? 2'h0 : _T_236; // @[Lookup.scala 33:37]
  wire [1:0] _T_238 = _T_19 ? 2'h1 : _T_237; // @[Lookup.scala 33:37]
  wire [1:0] _T_239 = _T_17 ? 2'h1 : _T_238; // @[Lookup.scala 33:37]
  wire [1:0] _T_240 = _T_15 ? 2'h0 : _T_239; // @[Lookup.scala 33:37]
  wire [1:0] _T_241 = _T_13 ? 2'h0 : _T_240; // @[Lookup.scala 33:37]
  wire [1:0] _T_242 = _T_11 ? 2'h0 : _T_241; // @[Lookup.scala 33:37]
  wire [1:0] _T_243 = _T_9 ? 2'h0 : _T_242; // @[Lookup.scala 33:37]
  wire [1:0] _T_244 = _T_7 ? 2'h0 : _T_243; // @[Lookup.scala 33:37]
  wire [1:0] _T_245 = _T_5 ? 2'h0 : _T_244; // @[Lookup.scala 33:37]
  wire [1:0] _T_246 = _T_3 ? 2'h0 : _T_245; // @[Lookup.scala 33:37]
  wire [1:0] _T_266 = _T_61 ? 2'h1 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _T_267 = _T_59 ? 2'h0 : _T_266; // @[Lookup.scala 33:37]
  wire [1:0] _T_268 = _T_57 ? 2'h0 : _T_267; // @[Lookup.scala 33:37]
  wire [1:0] _T_269 = _T_55 ? 2'h0 : _T_268; // @[Lookup.scala 33:37]
  wire [1:0] _T_270 = _T_53 ? 2'h0 : _T_269; // @[Lookup.scala 33:37]
  wire [1:0] _T_271 = _T_51 ? 2'h0 : _T_270; // @[Lookup.scala 33:37]
  wire [1:0] _T_272 = _T_49 ? 2'h0 : _T_271; // @[Lookup.scala 33:37]
  wire [1:0] _T_273 = _T_47 ? 2'h0 : _T_272; // @[Lookup.scala 33:37]
  wire [1:0] _T_274 = _T_45 ? 2'h0 : _T_273; // @[Lookup.scala 33:37]
  wire [1:0] _T_275 = _T_43 ? 2'h0 : _T_274; // @[Lookup.scala 33:37]
  wire [1:0] _T_276 = _T_41 ? 2'h0 : _T_275; // @[Lookup.scala 33:37]
  wire [1:0] _T_277 = _T_39 ? 2'h0 : _T_276; // @[Lookup.scala 33:37]
  wire [1:0] _T_278 = _T_37 ? 2'h1 : _T_277; // @[Lookup.scala 33:37]
  wire [1:0] _T_279 = _T_35 ? 2'h1 : _T_278; // @[Lookup.scala 33:37]
  wire [1:0] _T_280 = _T_33 ? 2'h1 : _T_279; // @[Lookup.scala 33:37]
  wire [1:0] _T_281 = _T_31 ? 2'h1 : _T_280; // @[Lookup.scala 33:37]
  wire [1:0] _T_282 = _T_29 ? 2'h1 : _T_281; // @[Lookup.scala 33:37]
  wire [1:0] _T_283 = _T_27 ? 2'h1 : _T_282; // @[Lookup.scala 33:37]
  wire [1:0] _T_284 = _T_25 ? 2'h1 : _T_283; // @[Lookup.scala 33:37]
  wire [1:0] _T_285 = _T_23 ? 2'h1 : _T_284; // @[Lookup.scala 33:37]
  wire [1:0] _T_286 = _T_21 ? 2'h1 : _T_285; // @[Lookup.scala 33:37]
  wire [1:0] _T_287 = _T_19 ? 2'h0 : _T_286; // @[Lookup.scala 33:37]
  wire [1:0] _T_288 = _T_17 ? 2'h3 : _T_287; // @[Lookup.scala 33:37]
  wire [1:0] _T_289 = _T_15 ? 2'h2 : _T_288; // @[Lookup.scala 33:37]
  wire [1:0] _T_290 = _T_13 ? 2'h2 : _T_289; // @[Lookup.scala 33:37]
  wire [1:0] _T_291 = _T_11 ? 2'h2 : _T_290; // @[Lookup.scala 33:37]
  wire [1:0] _T_292 = _T_9 ? 2'h1 : _T_291; // @[Lookup.scala 33:37]
  wire [1:0] _T_293 = _T_7 ? 2'h1 : _T_292; // @[Lookup.scala 33:37]
  wire [1:0] _T_294 = _T_5 ? 2'h1 : _T_293; // @[Lookup.scala 33:37]
  wire [1:0] _T_295 = _T_3 ? 2'h1 : _T_294; // @[Lookup.scala 33:37]
  wire [3:0] _T_303 = _T_85 ? 4'hb : 4'h0; // @[Lookup.scala 33:37]
  wire [3:0] _T_304 = _T_83 ? 4'hb : _T_303; // @[Lookup.scala 33:37]
  wire [3:0] _T_305 = _T_81 ? 4'hb : _T_304; // @[Lookup.scala 33:37]
  wire [3:0] _T_306 = _T_79 ? 4'hb : _T_305; // @[Lookup.scala 33:37]
  wire [3:0] _T_307 = _T_77 ? 4'hb : _T_306; // @[Lookup.scala 33:37]
  wire [3:0] _T_308 = _T_75 ? 4'hb : _T_307; // @[Lookup.scala 33:37]
  wire [3:0] _T_309 = _T_73 ? 4'h0 : _T_308; // @[Lookup.scala 33:37]
  wire [3:0] _T_310 = _T_71 ? 4'h0 : _T_309; // @[Lookup.scala 33:37]
  wire [3:0] _T_311 = _T_69 ? 4'h0 : _T_310; // @[Lookup.scala 33:37]
  wire [3:0] _T_312 = _T_67 ? 4'h0 : _T_311; // @[Lookup.scala 33:37]
  wire [3:0] _T_313 = _T_65 ? 4'h0 : _T_312; // @[Lookup.scala 33:37]
  wire [3:0] _T_314 = _T_63 ? 4'h0 : _T_313; // @[Lookup.scala 33:37]
  wire [3:0] _T_315 = _T_61 ? 4'h0 : _T_314; // @[Lookup.scala 33:37]
  wire [3:0] _T_316 = _T_59 ? 4'h0 : _T_315; // @[Lookup.scala 33:37]
  wire [3:0] _T_317 = _T_57 ? 4'h4 : _T_316; // @[Lookup.scala 33:37]
  wire [3:0] _T_318 = _T_55 ? 4'h5 : _T_317; // @[Lookup.scala 33:37]
  wire [3:0] _T_319 = _T_53 ? 4'h8 : _T_318; // @[Lookup.scala 33:37]
  wire [3:0] _T_320 = _T_51 ? 4'h7 : _T_319; // @[Lookup.scala 33:37]
  wire [3:0] _T_321 = _T_49 ? 4'h6 : _T_320; // @[Lookup.scala 33:37]
  wire [3:0] _T_322 = _T_47 ? 4'ha : _T_321; // @[Lookup.scala 33:37]
  wire [3:0] _T_323 = _T_45 ? 4'h9 : _T_322; // @[Lookup.scala 33:37]
  wire [3:0] _T_324 = _T_43 ? 4'h2 : _T_323; // @[Lookup.scala 33:37]
  wire [3:0] _T_325 = _T_41 ? 4'h1 : _T_324; // @[Lookup.scala 33:37]
  wire [3:0] _T_326 = _T_39 ? 4'h3 : _T_325; // @[Lookup.scala 33:37]
  wire [3:0] _T_327 = _T_37 ? 4'h4 : _T_326; // @[Lookup.scala 33:37]
  wire [3:0] _T_328 = _T_35 ? 4'h5 : _T_327; // @[Lookup.scala 33:37]
  wire [3:0] _T_329 = _T_33 ? 4'h3 : _T_328; // @[Lookup.scala 33:37]
  wire [3:0] _T_330 = _T_31 ? 4'ha : _T_329; // @[Lookup.scala 33:37]
  wire [3:0] _T_331 = _T_29 ? 4'h9 : _T_330; // @[Lookup.scala 33:37]
  wire [3:0] _T_332 = _T_27 ? 4'h8 : _T_331; // @[Lookup.scala 33:37]
  wire [3:0] _T_333 = _T_25 ? 4'h7 : _T_332; // @[Lookup.scala 33:37]
  wire [3:0] _T_334 = _T_23 ? 4'h6 : _T_333; // @[Lookup.scala 33:37]
  wire [3:0] _T_335 = _T_21 ? 4'h1 : _T_334; // @[Lookup.scala 33:37]
  wire [3:0] _T_336 = _T_19 ? 4'hb : _T_335; // @[Lookup.scala 33:37]
  wire [3:0] _T_337 = _T_17 ? 4'h1 : _T_336; // @[Lookup.scala 33:37]
  wire [3:0] _T_338 = _T_15 ? 4'h1 : _T_337; // @[Lookup.scala 33:37]
  wire [3:0] _T_339 = _T_13 ? 4'h1 : _T_338; // @[Lookup.scala 33:37]
  wire [3:0] _T_340 = _T_11 ? 4'h1 : _T_339; // @[Lookup.scala 33:37]
  wire [3:0] _T_341 = _T_9 ? 4'h1 : _T_340; // @[Lookup.scala 33:37]
  wire [3:0] _T_342 = _T_7 ? 4'h1 : _T_341; // @[Lookup.scala 33:37]
  wire [3:0] _T_343 = _T_5 ? 4'h1 : _T_342; // @[Lookup.scala 33:37]
  wire [3:0] _T_344 = _T_3 ? 4'h1 : _T_343; // @[Lookup.scala 33:37]
  wire [1:0] _T_352 = _T_85 ? 2'h3 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _T_353 = _T_83 ? 2'h3 : _T_352; // @[Lookup.scala 33:37]
  wire [1:0] _T_354 = _T_81 ? 2'h3 : _T_353; // @[Lookup.scala 33:37]
  wire [1:0] _T_355 = _T_79 ? 2'h3 : _T_354; // @[Lookup.scala 33:37]
  wire [1:0] _T_356 = _T_77 ? 2'h3 : _T_355; // @[Lookup.scala 33:37]
  wire [1:0] _T_357 = _T_75 ? 2'h3 : _T_356; // @[Lookup.scala 33:37]
  wire [1:0] _T_358 = _T_73 ? 2'h0 : _T_357; // @[Lookup.scala 33:37]
  wire [1:0] _T_359 = _T_71 ? 2'h0 : _T_358; // @[Lookup.scala 33:37]
  wire [1:0] _T_360 = _T_69 ? 2'h0 : _T_359; // @[Lookup.scala 33:37]
  wire [1:0] _T_361 = _T_67 ? 2'h0 : _T_360; // @[Lookup.scala 33:37]
  wire [1:0] _T_362 = _T_65 ? 2'h0 : _T_361; // @[Lookup.scala 33:37]
  wire [1:0] _T_363 = _T_63 ? 2'h0 : _T_362; // @[Lookup.scala 33:37]
  wire [1:0] _T_364 = _T_61 ? 2'h2 : _T_363; // @[Lookup.scala 33:37]
  wire [1:0] _T_365 = _T_59 ? 2'h2 : _T_364; // @[Lookup.scala 33:37]
  wire [1:0] _T_366 = _T_57 ? 2'h0 : _T_365; // @[Lookup.scala 33:37]
  wire [1:0] _T_367 = _T_55 ? 2'h0 : _T_366; // @[Lookup.scala 33:37]
  wire [1:0] _T_368 = _T_53 ? 2'h0 : _T_367; // @[Lookup.scala 33:37]
  wire [1:0] _T_369 = _T_51 ? 2'h0 : _T_368; // @[Lookup.scala 33:37]
  wire [1:0] _T_370 = _T_49 ? 2'h0 : _T_369; // @[Lookup.scala 33:37]
  wire [1:0] _T_371 = _T_47 ? 2'h0 : _T_370; // @[Lookup.scala 33:37]
  wire [1:0] _T_372 = _T_45 ? 2'h0 : _T_371; // @[Lookup.scala 33:37]
  wire [1:0] _T_373 = _T_43 ? 2'h0 : _T_372; // @[Lookup.scala 33:37]
  wire [1:0] _T_374 = _T_41 ? 2'h0 : _T_373; // @[Lookup.scala 33:37]
  wire [1:0] _T_375 = _T_39 ? 2'h0 : _T_374; // @[Lookup.scala 33:37]
  wire [1:0] _T_376 = _T_37 ? 2'h0 : _T_375; // @[Lookup.scala 33:37]
  wire [1:0] _T_377 = _T_35 ? 2'h0 : _T_376; // @[Lookup.scala 33:37]
  wire [1:0] _T_378 = _T_33 ? 2'h0 : _T_377; // @[Lookup.scala 33:37]
  wire [1:0] _T_379 = _T_31 ? 2'h0 : _T_378; // @[Lookup.scala 33:37]
  wire [1:0] _T_380 = _T_29 ? 2'h0 : _T_379; // @[Lookup.scala 33:37]
  wire [1:0] _T_381 = _T_27 ? 2'h0 : _T_380; // @[Lookup.scala 33:37]
  wire [1:0] _T_382 = _T_25 ? 2'h0 : _T_381; // @[Lookup.scala 33:37]
  wire [1:0] _T_383 = _T_23 ? 2'h0 : _T_382; // @[Lookup.scala 33:37]
  wire [1:0] _T_384 = _T_21 ? 2'h0 : _T_383; // @[Lookup.scala 33:37]
  wire [1:0] _T_385 = _T_19 ? 2'h0 : _T_384; // @[Lookup.scala 33:37]
  wire [1:0] _T_386 = _T_17 ? 2'h0 : _T_385; // @[Lookup.scala 33:37]
  wire [1:0] _T_387 = _T_15 ? 2'h0 : _T_386; // @[Lookup.scala 33:37]
  wire [1:0] _T_388 = _T_13 ? 2'h0 : _T_387; // @[Lookup.scala 33:37]
  wire [1:0] _T_389 = _T_11 ? 2'h0 : _T_388; // @[Lookup.scala 33:37]
  wire [1:0] _T_390 = _T_9 ? 2'h1 : _T_389; // @[Lookup.scala 33:37]
  wire [1:0] _T_391 = _T_7 ? 2'h1 : _T_390; // @[Lookup.scala 33:37]
  wire [1:0] _T_392 = _T_5 ? 2'h1 : _T_391; // @[Lookup.scala 33:37]
  wire [1:0] _T_393 = _T_3 ? 2'h1 : _T_392; // @[Lookup.scala 33:37]
  wire  _T_407 = _T_73 ? 1'h0 : _T_75 | (_T_77 | (_T_79 | (_T_81 | (_T_83 | _T_85)))); // @[Lookup.scala 33:37]
  wire  _T_408 = _T_71 ? 1'h0 : _T_407; // @[Lookup.scala 33:37]
  wire  _T_409 = _T_69 ? 1'h0 : _T_408; // @[Lookup.scala 33:37]
  wire  _T_410 = _T_67 ? 1'h0 : _T_409; // @[Lookup.scala 33:37]
  wire  _T_411 = _T_65 ? 1'h0 : _T_410; // @[Lookup.scala 33:37]
  wire  _T_412 = _T_63 ? 1'h0 : _T_411; // @[Lookup.scala 33:37]
  wire  _T_436 = _T_15 ? 1'h0 : _T_17 | (_T_19 | (_T_21 | (_T_23 | (_T_25 | (_T_27 | (_T_29 | (_T_31 | (_T_33 | (_T_35
     | (_T_37 | (_T_39 | (_T_41 | (_T_43 | (_T_45 | (_T_47 | (_T_49 | (_T_51 | (_T_53 | (_T_55 | (_T_57 | (_T_59 | (
    _T_61 | _T_412)))))))))))))))))))))); // @[Lookup.scala 33:37]
  wire  _T_437 = _T_13 ? 1'h0 : _T_436; // @[Lookup.scala 33:37]
  wire  _T_438 = _T_11 ? 1'h0 : _T_437; // @[Lookup.scala 33:37]
  wire  cs0_2 = _T_1 | (_T_3 | (_T_5 | (_T_7 | (_T_9 | _T_438)))); // @[Lookup.scala 33:37]
  wire  _T_444 = _T_97 ? 1'h0 : _T_99; // @[Lookup.scala 33:37]
  wire  _T_445 = _T_95 ? 1'h0 : _T_444; // @[Lookup.scala 33:37]
  wire  _T_446 = _T_93 ? 1'h0 : _T_445; // @[Lookup.scala 33:37]
  wire  _T_447 = _T_91 ? 1'h0 : _T_446; // @[Lookup.scala 33:37]
  wire  _T_448 = _T_89 ? 1'h0 : _T_447; // @[Lookup.scala 33:37]
  wire  _T_449 = _T_87 ? 1'h0 : _T_448; // @[Lookup.scala 33:37]
  wire  _T_450 = _T_85 ? 1'h0 : _T_449; // @[Lookup.scala 33:37]
  wire  _T_451 = _T_83 ? 1'h0 : _T_450; // @[Lookup.scala 33:37]
  wire  _T_452 = _T_81 ? 1'h0 : _T_451; // @[Lookup.scala 33:37]
  wire  _T_453 = _T_79 ? 1'h0 : _T_452; // @[Lookup.scala 33:37]
  wire  _T_454 = _T_77 ? 1'h0 : _T_453; // @[Lookup.scala 33:37]
  wire  _T_455 = _T_75 ? 1'h0 : _T_454; // @[Lookup.scala 33:37]
  wire  _T_456 = _T_73 ? 1'h0 : _T_455; // @[Lookup.scala 33:37]
  wire  _T_457 = _T_71 ? 1'h0 : _T_456; // @[Lookup.scala 33:37]
  wire  _T_458 = _T_69 ? 1'h0 : _T_457; // @[Lookup.scala 33:37]
  wire  _T_459 = _T_67 ? 1'h0 : _T_458; // @[Lookup.scala 33:37]
  wire  _T_460 = _T_65 ? 1'h0 : _T_459; // @[Lookup.scala 33:37]
  wire  _T_461 = _T_63 ? 1'h0 : _T_460; // @[Lookup.scala 33:37]
  wire  _T_462 = _T_61 ? 1'h0 : _T_461; // @[Lookup.scala 33:37]
  wire  _T_463 = _T_59 ? 1'h0 : _T_462; // @[Lookup.scala 33:37]
  wire  _T_464 = _T_57 ? 1'h0 : _T_463; // @[Lookup.scala 33:37]
  wire  _T_465 = _T_55 ? 1'h0 : _T_464; // @[Lookup.scala 33:37]
  wire  _T_466 = _T_53 ? 1'h0 : _T_465; // @[Lookup.scala 33:37]
  wire  _T_467 = _T_51 ? 1'h0 : _T_466; // @[Lookup.scala 33:37]
  wire  _T_468 = _T_49 ? 1'h0 : _T_467; // @[Lookup.scala 33:37]
  wire  _T_469 = _T_47 ? 1'h0 : _T_468; // @[Lookup.scala 33:37]
  wire  _T_470 = _T_45 ? 1'h0 : _T_469; // @[Lookup.scala 33:37]
  wire  _T_471 = _T_43 ? 1'h0 : _T_470; // @[Lookup.scala 33:37]
  wire  _T_472 = _T_41 ? 1'h0 : _T_471; // @[Lookup.scala 33:37]
  wire  _T_473 = _T_39 ? 1'h0 : _T_472; // @[Lookup.scala 33:37]
  wire  _T_474 = _T_37 ? 1'h0 : _T_473; // @[Lookup.scala 33:37]
  wire  _T_475 = _T_35 ? 1'h0 : _T_474; // @[Lookup.scala 33:37]
  wire  _T_476 = _T_33 ? 1'h0 : _T_475; // @[Lookup.scala 33:37]
  wire  _T_477 = _T_31 ? 1'h0 : _T_476; // @[Lookup.scala 33:37]
  wire  _T_478 = _T_29 ? 1'h0 : _T_477; // @[Lookup.scala 33:37]
  wire  _T_479 = _T_27 ? 1'h0 : _T_478; // @[Lookup.scala 33:37]
  wire  _T_480 = _T_25 ? 1'h0 : _T_479; // @[Lookup.scala 33:37]
  wire  _T_481 = _T_23 ? 1'h0 : _T_480; // @[Lookup.scala 33:37]
  wire  _T_482 = _T_21 ? 1'h0 : _T_481; // @[Lookup.scala 33:37]
  wire  _T_483 = _T_19 ? 1'h0 : _T_482; // @[Lookup.scala 33:37]
  wire  _T_484 = _T_17 ? 1'h0 : _T_483; // @[Lookup.scala 33:37]
  wire  cs0_3 = _T_1 | (_T_3 | (_T_5 | (_T_7 | (_T_9 | (_T_11 | (_T_13 | (_T_15 | _T_484))))))); // @[Lookup.scala 33:37]
  wire  _T_537 = _T_9 ? 1'h0 : _T_11 | (_T_13 | _T_15); // @[Lookup.scala 33:37]
  wire  _T_538 = _T_7 ? 1'h0 : _T_537; // @[Lookup.scala 33:37]
  wire  _T_539 = _T_5 ? 1'h0 : _T_538; // @[Lookup.scala 33:37]
  wire  _T_540 = _T_3 ? 1'h0 : _T_539; // @[Lookup.scala 33:37]
  wire [2:0] _T_583 = _T_15 ? 3'h2 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _T_584 = _T_13 ? 3'h1 : _T_583; // @[Lookup.scala 33:37]
  wire [2:0] _T_585 = _T_11 ? 3'h3 : _T_584; // @[Lookup.scala 33:37]
  wire [2:0] _T_586 = _T_9 ? 3'h6 : _T_585; // @[Lookup.scala 33:37]
  wire [2:0] _T_587 = _T_7 ? 3'h2 : _T_586; // @[Lookup.scala 33:37]
  wire [2:0] _T_588 = _T_5 ? 3'h5 : _T_587; // @[Lookup.scala 33:37]
  wire [2:0] _T_589 = _T_3 ? 3'h1 : _T_588; // @[Lookup.scala 33:37]
  wire [2:0] _T_593 = _T_93 ? 3'h4 : 3'h0; // @[Lookup.scala 33:37]
  wire [2:0] _T_594 = _T_91 ? 3'h4 : _T_593; // @[Lookup.scala 33:37]
  wire [2:0] _T_595 = _T_89 ? 3'h4 : _T_594; // @[Lookup.scala 33:37]
  wire [2:0] _T_596 = _T_87 ? 3'h4 : _T_595; // @[Lookup.scala 33:37]
  wire [2:0] _T_597 = _T_85 ? 3'h3 : _T_596; // @[Lookup.scala 33:37]
  wire [2:0] _T_598 = _T_83 ? 3'h2 : _T_597; // @[Lookup.scala 33:37]
  wire [2:0] _T_599 = _T_81 ? 3'h1 : _T_598; // @[Lookup.scala 33:37]
  wire [2:0] _T_600 = _T_79 ? 3'h3 : _T_599; // @[Lookup.scala 33:37]
  wire [2:0] _T_601 = _T_77 ? 3'h2 : _T_600; // @[Lookup.scala 33:37]
  wire [2:0] _T_602 = _T_75 ? 3'h1 : _T_601; // @[Lookup.scala 33:37]
  wire [2:0] _T_603 = _T_73 ? 3'h0 : _T_602; // @[Lookup.scala 33:37]
  wire [2:0] _T_604 = _T_71 ? 3'h0 : _T_603; // @[Lookup.scala 33:37]
  wire [2:0] _T_605 = _T_69 ? 3'h0 : _T_604; // @[Lookup.scala 33:37]
  wire [2:0] _T_606 = _T_67 ? 3'h0 : _T_605; // @[Lookup.scala 33:37]
  wire [2:0] _T_607 = _T_65 ? 3'h0 : _T_606; // @[Lookup.scala 33:37]
  wire [2:0] _T_608 = _T_63 ? 3'h0 : _T_607; // @[Lookup.scala 33:37]
  wire [2:0] _T_609 = _T_61 ? 3'h0 : _T_608; // @[Lookup.scala 33:37]
  wire [2:0] _T_610 = _T_59 ? 3'h0 : _T_609; // @[Lookup.scala 33:37]
  wire [2:0] _T_611 = _T_57 ? 3'h0 : _T_610; // @[Lookup.scala 33:37]
  wire [2:0] _T_612 = _T_55 ? 3'h0 : _T_611; // @[Lookup.scala 33:37]
  wire [2:0] _T_613 = _T_53 ? 3'h0 : _T_612; // @[Lookup.scala 33:37]
  wire [2:0] _T_614 = _T_51 ? 3'h0 : _T_613; // @[Lookup.scala 33:37]
  wire [2:0] _T_615 = _T_49 ? 3'h0 : _T_614; // @[Lookup.scala 33:37]
  wire [2:0] _T_616 = _T_47 ? 3'h0 : _T_615; // @[Lookup.scala 33:37]
  wire [2:0] _T_617 = _T_45 ? 3'h0 : _T_616; // @[Lookup.scala 33:37]
  wire [2:0] _T_618 = _T_43 ? 3'h0 : _T_617; // @[Lookup.scala 33:37]
  wire [2:0] _T_619 = _T_41 ? 3'h0 : _T_618; // @[Lookup.scala 33:37]
  wire [2:0] _T_620 = _T_39 ? 3'h0 : _T_619; // @[Lookup.scala 33:37]
  wire [2:0] _T_621 = _T_37 ? 3'h0 : _T_620; // @[Lookup.scala 33:37]
  wire [2:0] _T_622 = _T_35 ? 3'h0 : _T_621; // @[Lookup.scala 33:37]
  wire [2:0] _T_623 = _T_33 ? 3'h0 : _T_622; // @[Lookup.scala 33:37]
  wire [2:0] _T_624 = _T_31 ? 3'h0 : _T_623; // @[Lookup.scala 33:37]
  wire [2:0] _T_625 = _T_29 ? 3'h0 : _T_624; // @[Lookup.scala 33:37]
  wire [2:0] _T_626 = _T_27 ? 3'h0 : _T_625; // @[Lookup.scala 33:37]
  wire [2:0] _T_627 = _T_25 ? 3'h0 : _T_626; // @[Lookup.scala 33:37]
  wire [2:0] _T_628 = _T_23 ? 3'h0 : _T_627; // @[Lookup.scala 33:37]
  wire [2:0] _T_629 = _T_21 ? 3'h0 : _T_628; // @[Lookup.scala 33:37]
  wire [2:0] _T_630 = _T_19 ? 3'h0 : _T_629; // @[Lookup.scala 33:37]
  wire [2:0] _T_631 = _T_17 ? 3'h0 : _T_630; // @[Lookup.scala 33:37]
  wire [2:0] _T_632 = _T_15 ? 3'h0 : _T_631; // @[Lookup.scala 33:37]
  wire [2:0] _T_633 = _T_13 ? 3'h0 : _T_632; // @[Lookup.scala 33:37]
  wire [2:0] _T_634 = _T_11 ? 3'h0 : _T_633; // @[Lookup.scala 33:37]
  wire [2:0] _T_635 = _T_9 ? 3'h0 : _T_634; // @[Lookup.scala 33:37]
  wire [2:0] _T_636 = _T_7 ? 3'h0 : _T_635; // @[Lookup.scala 33:37]
  wire [2:0] _T_637 = _T_5 ? 3'h0 : _T_636; // @[Lookup.scala 33:37]
  wire [2:0] _T_638 = _T_3 ? 3'h0 : _T_637; // @[Lookup.scala 33:37]
  wire [2:0] cs0_6 = _T_1 ? 3'h0 : _T_638; // @[Lookup.scala 33:37]
  wire [2:0] _T_643 = ~io_dat_br_eq ? 3'h1 : 3'h0; // @[cpath.scala 121:53]
  wire [2:0] _T_645 = io_dat_br_eq ? 3'h1 : 3'h0; // @[cpath.scala 122:53]
  wire [2:0] _T_648 = ~io_dat_br_lt ? 3'h1 : 3'h0; // @[cpath.scala 123:53]
  wire [2:0] _T_651 = ~io_dat_br_ltu ? 3'h1 : 3'h0; // @[cpath.scala 124:53]
  wire [2:0] _T_653 = io_dat_br_lt ? 3'h1 : 3'h0; // @[cpath.scala 125:53]
  wire [2:0] _T_655 = io_dat_br_ltu ? 3'h1 : 3'h0; // @[cpath.scala 126:53]
  wire [2:0] _T_658 = cs_br_type == 4'h8 ? 3'h3 : 3'h0; // @[cpath.scala 128:25]
  wire [2:0] _T_659 = cs_br_type == 4'h7 ? 3'h2 : _T_658; // @[cpath.scala 127:25]
  wire [2:0] _T_660 = cs_br_type == 4'h6 ? _T_655 : _T_659; // @[cpath.scala 126:25]
  wire [2:0] _T_661 = cs_br_type == 4'h5 ? _T_653 : _T_660; // @[cpath.scala 125:25]
  wire [2:0] _T_662 = cs_br_type == 4'h4 ? _T_651 : _T_661; // @[cpath.scala 124:25]
  wire [2:0] _T_663 = cs_br_type == 4'h3 ? _T_648 : _T_662; // @[cpath.scala 123:25]
  wire [2:0] _T_664 = cs_br_type == 4'h2 ? _T_645 : _T_663; // @[cpath.scala 122:25]
  wire [2:0] _T_665 = cs_br_type == 4'h1 ? _T_643 : _T_664; // @[cpath.scala 121:25]
  wire [2:0] _T_666 = cs_br_type == 4'h0 ? 3'h0 : _T_665; // @[cpath.scala 120:25]
  wire  stall = ~(cs0_3 & io_dmem_resp_valid | ~cs0_3); // @[cpath.scala 131:40]
  wire [4:0] rs1_addr = io_dat_inst[19:15]; // @[cpath.scala 143:30]
  wire  csr_ren = (cs0_6 == 3'h2 | cs0_6 == 3'h3) & rs1_addr == 5'h0; // @[cpath.scala 144:65]
  wire [2:0] csr_cmd = csr_ren ? 3'h5 : cs0_6; // @[cpath.scala 145:21]
  assign io_dmem_req_valid = _T_1 | (_T_3 | (_T_5 | (_T_7 | (_T_9 | (_T_11 | (_T_13 | (_T_15 | _T_484))))))); // @[Lookup.scala 33:37]
  assign io_dmem_req_bits_fcn = _T_1 ? 1'h0 : _T_540; // @[Lookup.scala 33:37]
  assign io_dmem_req_bits_typ = _T_1 ? 3'h3 : _T_589; // @[Lookup.scala 33:37]
  assign io_ctl_stall = ~(cs0_3 & io_dmem_resp_valid | ~cs0_3); // @[cpath.scala 131:40]
  assign io_ctl_pc_sel = io_dat_csr_eret | io_ctl_exception ? 3'h4 : _T_666; // @[cpath.scala 118:25]
  assign io_ctl_op1_sel = _T_1 ? 2'h0 : _T_246; // @[Lookup.scala 33:37]
  assign io_ctl_op2_sel = _T_1 ? 2'h1 : _T_295; // @[Lookup.scala 33:37]
  assign io_ctl_alu_fun = _T_1 ? 4'h1 : _T_344; // @[Lookup.scala 33:37]
  assign io_ctl_wb_sel = _T_1 ? 2'h1 : _T_393; // @[Lookup.scala 33:37]
  assign io_ctl_rf_wen = stall | io_ctl_exception ? 1'h0 : cs0_2; // @[cpath.scala 140:26]
  assign io_ctl_csr_cmd = stall ? 3'h0 : csr_cmd; // @[cpath.scala 147:26]
  assign io_ctl_exception = ~cs_val_inst; // @[cpath.scala 164:25]
endmodule // CtlPath

module CSRFile(
  input         clock,
  input         reset,
  input  [2:0]  io_rw_cmd,
  output [31:0] io_rw_rdata,
  input  [31:0] io_rw_wdata,
  output        io_eret,
  input  [11:0] io_decode_csr,
  output        io_status_debug,
  output [1:0]  io_status_prv,
  output        io_status_sd,
  output [7:0]  io_status_zero1,
  output        io_status_tsr,
  output        io_status_tw,
  output        io_status_tvm,
  output        io_status_mxr,
  output        io_status_sum,
  output        io_status_mprv,
  output [1:0]  io_status_xs,
  output [1:0]  io_status_fs,
  output [1:0]  io_status_mpp,
  output [1:0]  io_status_hpp,
  output        io_status_spp,
  output        io_status_mpie,
  output        io_status_hpie,
  output        io_status_spie,
  output        io_status_upie,
  output        io_status_mie,
  output        io_status_hie,
  output        io_status_sie,
  output        io_status_uie,
  output [31:0] io_evec,
  input         io_exception,
  input         io_retire,
  input  [31:0] io_pc,
  output [31:0] io_time
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
  reg [63:0] _RAND_32;
  reg [63:0] _RAND_33;
  reg [63:0] _RAND_34;
  reg [63:0] _RAND_35;
  reg [63:0] _RAND_36;
  reg [63:0] _RAND_37;
  reg [63:0] _RAND_38;
  reg [63:0] _RAND_39;
  reg [63:0] _RAND_40;
  reg [63:0] _RAND_41;
  reg [63:0] _RAND_42;
  reg [63:0] _RAND_43;
  reg [63:0] _RAND_44;
  reg [63:0] _RAND_45;
  reg [63:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
`endif // RANDOMIZE_REG_INIT
  reg  reg_mstatus_mpie; // @[csr.scala 163:28]
  reg  reg_mstatus_mie; // @[csr.scala 163:28]
  reg [31:0] reg_mepc; // @[csr.scala 164:21]
  reg [31:0] reg_mcause; // @[csr.scala 165:23]
  reg [31:0] reg_mtval; // @[csr.scala 166:22]
  reg [31:0] reg_mscratch; // @[csr.scala 167:25]
  reg [31:0] reg_medeleg; // @[csr.scala 169:24]
  reg  reg_mip_mtip; // @[csr.scala 171:24]
  reg  reg_mip_msip; // @[csr.scala 171:24]
  reg  reg_mie_mtip; // @[csr.scala 172:24]
  reg  reg_mie_msip; // @[csr.scala 172:24]
  reg [5:0] REG; // @[util.scala 114:41]
  wire [6:0] _T = REG + 6'h1; // @[util.scala 115:33]
  reg [57:0] REG_1; // @[util.scala 119:31]
  wire [57:0] _T_3 = REG_1 + 58'h1; // @[util.scala 120:43]
  wire [57:0] _GEN_0 = _T[6] ? _T_3 : REG_1; // @[util.scala 120:34 util.scala 120:38 util.scala 119:31]
  wire [63:0] _T_4 = {REG_1,REG}; // @[Cat.scala 30:58]
  reg [5:0] REG_2; // @[util.scala 114:41]
  wire [5:0] _GEN_150 = {{5'd0}, io_retire}; // @[util.scala 115:33]
  wire [6:0] _T_5 = REG_2 + _GEN_150; // @[util.scala 115:33]
  reg [57:0] REG_3; // @[util.scala 119:31]
  wire [57:0] _T_8 = REG_3 + 58'h1; // @[util.scala 120:43]
  wire [57:0] _GEN_1 = _T_5[6] ? _T_8 : REG_3; // @[util.scala 120:34 util.scala 120:38 util.scala 119:31]
  wire [63:0] _T_9 = {REG_3,REG_2}; // @[Cat.scala 30:58]
  reg [39:0] REG_4; // @[util.scala 114:74]
  wire [40:0] _T_10 = {{1'd0}, REG_4}; // @[util.scala 115:33]
  reg [39:0] REG_5; // @[util.scala 114:74]
  wire [40:0] _T_11 = {{1'd0}, REG_5}; // @[util.scala 115:33]
  reg [39:0] REG_6; // @[util.scala 114:74]
  wire [40:0] _T_12 = {{1'd0}, REG_6}; // @[util.scala 115:33]
  reg [39:0] REG_7; // @[util.scala 114:74]
  wire [40:0] _T_13 = {{1'd0}, REG_7}; // @[util.scala 115:33]
  reg [39:0] REG_8; // @[util.scala 114:74]
  wire [40:0] _T_14 = {{1'd0}, REG_8}; // @[util.scala 115:33]
  reg [39:0] REG_9; // @[util.scala 114:74]
  wire [40:0] _T_15 = {{1'd0}, REG_9}; // @[util.scala 115:33]
  reg [39:0] REG_10; // @[util.scala 114:74]
  wire [40:0] _T_16 = {{1'd0}, REG_10}; // @[util.scala 115:33]
  reg [39:0] REG_11; // @[util.scala 114:74]
  wire [40:0] _T_17 = {{1'd0}, REG_11}; // @[util.scala 115:33]
  reg [39:0] REG_12; // @[util.scala 114:74]
  wire [40:0] _T_18 = {{1'd0}, REG_12}; // @[util.scala 115:33]
  reg [39:0] REG_13; // @[util.scala 114:74]
  wire [40:0] _T_19 = {{1'd0}, REG_13}; // @[util.scala 115:33]
  reg [39:0] REG_14; // @[util.scala 114:74]
  wire [40:0] _T_20 = {{1'd0}, REG_14}; // @[util.scala 115:33]
  reg [39:0] REG_15; // @[util.scala 114:74]
  wire [40:0] _T_21 = {{1'd0}, REG_15}; // @[util.scala 115:33]
  reg [39:0] REG_16; // @[util.scala 114:74]
  wire [40:0] _T_22 = {{1'd0}, REG_16}; // @[util.scala 115:33]
  reg [39:0] REG_17; // @[util.scala 114:74]
  wire [40:0] _T_23 = {{1'd0}, REG_17}; // @[util.scala 115:33]
  reg [39:0] REG_18; // @[util.scala 114:74]
  wire [40:0] _T_24 = {{1'd0}, REG_18}; // @[util.scala 115:33]
  reg [39:0] REG_19; // @[util.scala 114:74]
  wire [40:0] _T_25 = {{1'd0}, REG_19}; // @[util.scala 115:33]
  reg [39:0] REG_20; // @[util.scala 114:74]
  wire [40:0] _T_26 = {{1'd0}, REG_20}; // @[util.scala 115:33]
  reg [39:0] REG_21; // @[util.scala 114:74]
  wire [40:0] _T_27 = {{1'd0}, REG_21}; // @[util.scala 115:33]
  reg [39:0] REG_22; // @[util.scala 114:74]
  wire [40:0] _T_28 = {{1'd0}, REG_22}; // @[util.scala 115:33]
  reg [39:0] REG_23; // @[util.scala 114:74]
  wire [40:0] _T_29 = {{1'd0}, REG_23}; // @[util.scala 115:33]
  reg [39:0] REG_24; // @[util.scala 114:74]
  wire [40:0] _T_30 = {{1'd0}, REG_24}; // @[util.scala 115:33]
  reg [39:0] REG_25; // @[util.scala 114:74]
  wire [40:0] _T_31 = {{1'd0}, REG_25}; // @[util.scala 115:33]
  reg [39:0] REG_26; // @[util.scala 114:74]
  wire [40:0] _T_32 = {{1'd0}, REG_26}; // @[util.scala 115:33]
  reg [39:0] REG_27; // @[util.scala 114:74]
  wire [40:0] _T_33 = {{1'd0}, REG_27}; // @[util.scala 115:33]
  reg [39:0] REG_28; // @[util.scala 114:74]
  wire [40:0] _T_34 = {{1'd0}, REG_28}; // @[util.scala 115:33]
  reg [39:0] REG_29; // @[util.scala 114:74]
  wire [40:0] _T_35 = {{1'd0}, REG_29}; // @[util.scala 115:33]
  reg [39:0] REG_30; // @[util.scala 114:74]
  wire [40:0] _T_36 = {{1'd0}, REG_30}; // @[util.scala 115:33]
  reg [39:0] REG_31; // @[util.scala 114:74]
  wire [40:0] _T_37 = {{1'd0}, REG_31}; // @[util.scala 115:33]
  reg [39:0] REG_32; // @[util.scala 114:74]
  wire [40:0] _T_38 = {{1'd0}, REG_32}; // @[util.scala 115:33]
  reg [39:0] REG_33; // @[util.scala 114:74]
  wire [40:0] _T_39 = {{1'd0}, REG_33}; // @[util.scala 115:33]
  reg [39:0] REG_34; // @[util.scala 114:74]
  wire [40:0] _T_40 = {{1'd0}, REG_34}; // @[util.scala 115:33]
  reg [39:0] REG_35; // @[util.scala 114:74]
  wire [40:0] _T_41 = {{1'd0}, REG_35}; // @[util.scala 115:33]
  reg [31:0] reg_dpc; // @[csr.scala 188:20]
  reg [31:0] reg_dscratch; // @[csr.scala 189:25]
  reg  reg_dcsr_ebreakm; // @[csr.scala 194:25]
  reg  reg_dcsr_step; // @[csr.scala 194:25]
  wire  system_insn = io_rw_cmd == 3'h4; // @[csr.scala 196:31]
  wire  cpu_ren = io_rw_cmd != 3'h0 & ~system_insn; // @[csr.scala 197:37]
  wire [4:0] lo_lo = {io_status_upie,io_status_mie,io_status_hie,io_status_sie,io_status_uie}; // @[csr.scala 199:38]
  wire [12:0] lo = {io_status_mpp,io_status_hpp,io_status_spp,io_status_mpie,io_status_hpie,io_status_spie,lo_lo}; // @[csr.scala 199:38]
  wire [7:0] hi_lo = {io_status_tvm,io_status_mxr,io_status_sum,io_status_mprv,io_status_xs,io_status_fs}; // @[csr.scala 199:38]
  wire [34:0] read_mstatus = {io_status_debug,io_status_prv,io_status_sd,io_status_zero1,io_status_tsr,io_status_tw,
    hi_lo,lo}; // @[csr.scala 199:38]
  wire [15:0] _T_72 = {8'h0,reg_mip_mtip,1'h0,2'h0,reg_mip_msip,1'h0,2'h0}; // @[csr.scala 215:31]
  wire [15:0] _T_73 = {8'h0,reg_mie_mtip,1'h0,2'h0,reg_mie_msip,1'h0,2'h0}; // @[csr.scala 216:31]
  wire [31:0] _T_74 = {4'h4,12'h0,reg_dcsr_ebreakm,4'h0,6'h0,2'h0,reg_dcsr_step,2'h3}; // @[csr.scala 222:27]
  wire  _T_75 = io_decode_csr == 12'hb00; // @[csr.scala 259:76]
  wire  _T_76 = io_decode_csr == 12'hb02; // @[csr.scala 259:76]
  wire  _T_77 = io_decode_csr == 12'hf13; // @[csr.scala 259:76]
  wire  _T_80 = io_decode_csr == 12'h301; // @[csr.scala 259:76]
  wire  _T_81 = io_decode_csr == 12'h300; // @[csr.scala 259:76]
  wire  _T_82 = io_decode_csr == 12'h305; // @[csr.scala 259:76]
  wire  _T_83 = io_decode_csr == 12'h344; // @[csr.scala 259:76]
  wire  _T_84 = io_decode_csr == 12'h304; // @[csr.scala 259:76]
  wire  _T_85 = io_decode_csr == 12'h340; // @[csr.scala 259:76]
  wire  _T_86 = io_decode_csr == 12'h341; // @[csr.scala 259:76]
  wire  _T_87 = io_decode_csr == 12'h343; // @[csr.scala 259:76]
  wire  _T_88 = io_decode_csr == 12'h342; // @[csr.scala 259:76]
  wire  _T_90 = io_decode_csr == 12'h7b0; // @[csr.scala 259:76]
  wire  _T_91 = io_decode_csr == 12'h7b1; // @[csr.scala 259:76]
  wire  _T_92 = io_decode_csr == 12'h7b2; // @[csr.scala 259:76]
  wire  _T_93 = io_decode_csr == 12'h302; // @[csr.scala 259:76]
  wire  _T_94 = io_decode_csr == 12'hb03; // @[csr.scala 259:76]
  wire  _T_95 = io_decode_csr == 12'hb83; // @[csr.scala 259:76]
  wire  _T_96 = io_decode_csr == 12'hb04; // @[csr.scala 259:76]
  wire  _T_97 = io_decode_csr == 12'hb84; // @[csr.scala 259:76]
  wire  _T_98 = io_decode_csr == 12'hb05; // @[csr.scala 259:76]
  wire  _T_99 = io_decode_csr == 12'hb85; // @[csr.scala 259:76]
  wire  _T_100 = io_decode_csr == 12'hb06; // @[csr.scala 259:76]
  wire  _T_101 = io_decode_csr == 12'hb86; // @[csr.scala 259:76]
  wire  _T_102 = io_decode_csr == 12'hb07; // @[csr.scala 259:76]
  wire  _T_103 = io_decode_csr == 12'hb87; // @[csr.scala 259:76]
  wire  _T_104 = io_decode_csr == 12'hb08; // @[csr.scala 259:76]
  wire  _T_105 = io_decode_csr == 12'hb88; // @[csr.scala 259:76]
  wire  _T_106 = io_decode_csr == 12'hb09; // @[csr.scala 259:76]
  wire  _T_107 = io_decode_csr == 12'hb89; // @[csr.scala 259:76]
  wire  _T_108 = io_decode_csr == 12'hb0a; // @[csr.scala 259:76]
  wire  _T_109 = io_decode_csr == 12'hb8a; // @[csr.scala 259:76]
  wire  _T_110 = io_decode_csr == 12'hb0b; // @[csr.scala 259:76]
  wire  _T_111 = io_decode_csr == 12'hb8b; // @[csr.scala 259:76]
  wire  _T_112 = io_decode_csr == 12'hb0c; // @[csr.scala 259:76]
  wire  _T_113 = io_decode_csr == 12'hb8c; // @[csr.scala 259:76]
  wire  _T_114 = io_decode_csr == 12'hb0d; // @[csr.scala 259:76]
  wire  _T_115 = io_decode_csr == 12'hb8d; // @[csr.scala 259:76]
  wire  _T_116 = io_decode_csr == 12'hb0e; // @[csr.scala 259:76]
  wire  _T_117 = io_decode_csr == 12'hb8e; // @[csr.scala 259:76]
  wire  _T_118 = io_decode_csr == 12'hb0f; // @[csr.scala 259:76]
  wire  _T_119 = io_decode_csr == 12'hb8f; // @[csr.scala 259:76]
  wire  _T_120 = io_decode_csr == 12'hb10; // @[csr.scala 259:76]
  wire  _T_121 = io_decode_csr == 12'hb90; // @[csr.scala 259:76]
  wire  _T_122 = io_decode_csr == 12'hb11; // @[csr.scala 259:76]
  wire  _T_123 = io_decode_csr == 12'hb91; // @[csr.scala 259:76]
  wire  _T_124 = io_decode_csr == 12'hb12; // @[csr.scala 259:76]
  wire  _T_125 = io_decode_csr == 12'hb92; // @[csr.scala 259:76]
  wire  _T_126 = io_decode_csr == 12'hb13; // @[csr.scala 259:76]
  wire  _T_127 = io_decode_csr == 12'hb93; // @[csr.scala 259:76]
  wire  _T_128 = io_decode_csr == 12'hb14; // @[csr.scala 259:76]
  wire  _T_129 = io_decode_csr == 12'hb94; // @[csr.scala 259:76]
  wire  _T_130 = io_decode_csr == 12'hb15; // @[csr.scala 259:76]
  wire  _T_131 = io_decode_csr == 12'hb95; // @[csr.scala 259:76]
  wire  _T_132 = io_decode_csr == 12'hb16; // @[csr.scala 259:76]
  wire  _T_133 = io_decode_csr == 12'hb96; // @[csr.scala 259:76]
  wire  _T_134 = io_decode_csr == 12'hb17; // @[csr.scala 259:76]
  wire  _T_135 = io_decode_csr == 12'hb97; // @[csr.scala 259:76]
  wire  _T_136 = io_decode_csr == 12'hb18; // @[csr.scala 259:76]
  wire  _T_137 = io_decode_csr == 12'hb98; // @[csr.scala 259:76]
  wire  _T_138 = io_decode_csr == 12'hb19; // @[csr.scala 259:76]
  wire  _T_139 = io_decode_csr == 12'hb99; // @[csr.scala 259:76]
  wire  _T_140 = io_decode_csr == 12'hb1a; // @[csr.scala 259:76]
  wire  _T_141 = io_decode_csr == 12'hb9a; // @[csr.scala 259:76]
  wire  _T_142 = io_decode_csr == 12'hb1b; // @[csr.scala 259:76]
  wire  _T_143 = io_decode_csr == 12'hb9b; // @[csr.scala 259:76]
  wire  _T_144 = io_decode_csr == 12'hb1c; // @[csr.scala 259:76]
  wire  _T_145 = io_decode_csr == 12'hb9c; // @[csr.scala 259:76]
  wire  _T_146 = io_decode_csr == 12'hb1d; // @[csr.scala 259:76]
  wire  _T_147 = io_decode_csr == 12'hb9d; // @[csr.scala 259:76]
  wire  _T_148 = io_decode_csr == 12'hb1e; // @[csr.scala 259:76]
  wire  _T_149 = io_decode_csr == 12'hb9e; // @[csr.scala 259:76]
  wire  _T_150 = io_decode_csr == 12'hb1f; // @[csr.scala 259:76]
  wire  _T_151 = io_decode_csr == 12'hb9f; // @[csr.scala 259:76]
  wire  _T_152 = io_decode_csr == 12'hb20; // @[csr.scala 259:76]
  wire  _T_153 = io_decode_csr == 12'hba0; // @[csr.scala 259:76]
  wire  _T_154 = io_decode_csr == 12'hb21; // @[csr.scala 259:76]
  wire  _T_155 = io_decode_csr == 12'hba1; // @[csr.scala 259:76]
  wire  _T_156 = io_decode_csr == 12'hb22; // @[csr.scala 259:76]
  wire  _T_157 = io_decode_csr == 12'hba2; // @[csr.scala 259:76]
  wire  _T_158 = io_decode_csr == 12'hb80; // @[csr.scala 259:76]
  wire  _T_159 = io_decode_csr == 12'hb82; // @[csr.scala 259:76]
  wire  read_only = &io_decode_csr[11:10]; // @[csr.scala 262:40]
  wire  cpu_wen = cpu_ren & io_rw_cmd != 3'h5; // @[csr.scala 263:25]
  wire  wen = cpu_wen & ~read_only; // @[csr.scala 264:21]
  wire  _T_166 = io_rw_cmd == 3'h3; // @[util.scala 25:47]
  wire  _T_167 = io_rw_cmd == 3'h2 | io_rw_cmd == 3'h3; // @[util.scala 25:62]
  wire [31:0] _T_168 = _T_167 ? io_rw_rdata : 32'h0; // @[csr.scala 394:9]
  wire [31:0] _T_169 = _T_168 | io_rw_wdata; // @[csr.scala 394:49]
  wire [31:0] _T_171 = _T_166 ? io_rw_wdata : 32'h0; // @[csr.scala 394:64]
  wire [31:0] _T_172 = ~_T_171; // @[csr.scala 394:60]
  wire [31:0] wdata = _T_169 & _T_172; // @[csr.scala 394:58]
  wire [7:0] opcode = 8'h1 << io_decode_csr[2:0]; // @[csr.scala 267:20]
  wire  insn_call = system_insn & opcode[0]; // @[csr.scala 268:31]
  wire  insn_break = system_insn & opcode[1]; // @[csr.scala 269:32]
  wire  insn_ret = system_insn & opcode[2]; // @[csr.scala 270:30]
  wire [31:0] _GEN_2 = io_exception ? 32'h2 : reg_mcause; // @[csr.scala 286:23 csr.scala 287:16 csr.scala 165:23]
  wire [1:0] _T_369 = insn_ret + io_exception; // @[Bitwise.scala 47:55]
  wire [31:0] _GEN_6 = insn_ret & io_decode_csr[10] ? reg_dpc : 32'h80000004; // @[csr.scala 301:38 csr.scala 304:13 csr.scala 298:11]
  wire  _GEN_7 = insn_ret & ~io_decode_csr[10] ? reg_mstatus_mpie : reg_mstatus_mie; // @[csr.scala 308:41 csr.scala 309:21 csr.scala 163:28]
  wire  _GEN_8 = insn_ret & ~io_decode_csr[10] | reg_mstatus_mpie; // @[csr.scala 308:41 csr.scala 310:22 csr.scala 163:28]
  wire [31:0] _GEN_11 = insn_call ? 32'hb : _GEN_2; // @[csr.scala 316:18 csr.scala 317:16]
  wire [31:0] _GEN_12 = insn_break ? 32'h3 : _GEN_11; // @[csr.scala 321:19 csr.scala 322:16]
  wire [31:0] _GEN_13 = io_exception | insn_call | insn_break ? io_pc : reg_mepc; // @[csr.scala 325:50 csr.scala 326:14 csr.scala 164:21]
  wire [63:0] _T_385 = _T_75 ? _T_4 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _T_386 = _T_76 ? _T_9 : 64'h0; // @[Mux.scala 27:72]
  wire [15:0] _T_387 = _T_77 ? 16'h8000 : 16'h0; // @[Mux.scala 27:72]
  wire [8:0] _T_390 = _T_80 ? 9'h100 : 9'h0; // @[Mux.scala 27:72]
  wire [34:0] _T_391 = _T_81 ? read_mstatus : 35'h0; // @[Mux.scala 27:72]
  wire [8:0] _T_392 = _T_82 ? 9'h100 : 9'h0; // @[Mux.scala 27:72]
  wire [15:0] _T_393 = _T_83 ? _T_72 : 16'h0; // @[Mux.scala 27:72]
  wire [15:0] _T_394 = _T_84 ? _T_73 : 16'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_395 = _T_85 ? reg_mscratch : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_396 = _T_86 ? reg_mepc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_397 = _T_87 ? reg_mtval : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_398 = _T_88 ? reg_mcause : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_400 = _T_90 ? _T_74 : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_401 = _T_91 ? reg_dpc : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_402 = _T_92 ? reg_dscratch : 32'h0; // @[Mux.scala 27:72]
  wire [31:0] _T_403 = _T_93 ? reg_medeleg : 32'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_404 = _T_94 ? REG_4 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_405 = _T_95 ? REG_4 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_406 = _T_96 ? REG_5 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_407 = _T_97 ? REG_5 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_408 = _T_98 ? REG_6 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_409 = _T_99 ? REG_6 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_410 = _T_100 ? REG_7 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_411 = _T_101 ? REG_7 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_412 = _T_102 ? REG_8 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_413 = _T_103 ? REG_8 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_414 = _T_104 ? REG_9 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_415 = _T_105 ? REG_9 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_416 = _T_106 ? REG_10 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_417 = _T_107 ? REG_10 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_418 = _T_108 ? REG_11 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_419 = _T_109 ? REG_11 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_420 = _T_110 ? REG_12 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_421 = _T_111 ? REG_12 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_422 = _T_112 ? REG_13 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_423 = _T_113 ? REG_13 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_424 = _T_114 ? REG_14 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_425 = _T_115 ? REG_14 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_426 = _T_116 ? REG_15 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_427 = _T_117 ? REG_15 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_428 = _T_118 ? REG_16 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_429 = _T_119 ? REG_16 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_430 = _T_120 ? REG_17 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_431 = _T_121 ? REG_17 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_432 = _T_122 ? REG_18 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_433 = _T_123 ? REG_18 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_434 = _T_124 ? REG_19 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_435 = _T_125 ? REG_19 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_436 = _T_126 ? REG_20 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_437 = _T_127 ? REG_20 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_438 = _T_128 ? REG_21 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_439 = _T_129 ? REG_21 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_440 = _T_130 ? REG_22 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_441 = _T_131 ? REG_22 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_442 = _T_132 ? REG_23 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_443 = _T_133 ? REG_23 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_444 = _T_134 ? REG_24 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_445 = _T_135 ? REG_24 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_446 = _T_136 ? REG_25 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_447 = _T_137 ? REG_25 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_448 = _T_138 ? REG_26 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_449 = _T_139 ? REG_26 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_450 = _T_140 ? REG_27 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_451 = _T_141 ? REG_27 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_452 = _T_142 ? REG_28 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_453 = _T_143 ? REG_28 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_454 = _T_144 ? REG_29 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_455 = _T_145 ? REG_29 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_456 = _T_146 ? REG_30 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_457 = _T_147 ? REG_30 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_458 = _T_148 ? REG_31 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_459 = _T_149 ? REG_31 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_460 = _T_150 ? REG_32 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_461 = _T_151 ? REG_32 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_462 = _T_152 ? REG_33 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_463 = _T_153 ? REG_33 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_464 = _T_154 ? REG_34 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_465 = _T_155 ? REG_34 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_466 = _T_156 ? REG_35 : 40'h0; // @[Mux.scala 27:72]
  wire [39:0] _T_467 = _T_157 ? REG_35 : 40'h0; // @[Mux.scala 27:72]
  wire [63:0] _T_470 = _T_385 | _T_386; // @[Mux.scala 27:72]
  wire [63:0] _GEN_151 = {{48'd0}, _T_387}; // @[Mux.scala 27:72]
  wire [63:0] _T_471 = _T_470 | _GEN_151; // @[Mux.scala 27:72]
  wire [63:0] _GEN_152 = {{55'd0}, _T_390}; // @[Mux.scala 27:72]
  wire [63:0] _T_474 = _T_471 | _GEN_152; // @[Mux.scala 27:72]
  wire [63:0] _GEN_153 = {{29'd0}, _T_391}; // @[Mux.scala 27:72]
  wire [63:0] _T_475 = _T_474 | _GEN_153; // @[Mux.scala 27:72]
  wire [63:0] _GEN_154 = {{55'd0}, _T_392}; // @[Mux.scala 27:72]
  wire [63:0] _T_476 = _T_475 | _GEN_154; // @[Mux.scala 27:72]
  wire [63:0] _GEN_155 = {{48'd0}, _T_393}; // @[Mux.scala 27:72]
  wire [63:0] _T_477 = _T_476 | _GEN_155; // @[Mux.scala 27:72]
  wire [63:0] _GEN_156 = {{48'd0}, _T_394}; // @[Mux.scala 27:72]
  wire [63:0] _T_478 = _T_477 | _GEN_156; // @[Mux.scala 27:72]
  wire [63:0] _GEN_157 = {{32'd0}, _T_395}; // @[Mux.scala 27:72]
  wire [63:0] _T_479 = _T_478 | _GEN_157; // @[Mux.scala 27:72]
  wire [63:0] _GEN_158 = {{32'd0}, _T_396}; // @[Mux.scala 27:72]
  wire [63:0] _T_480 = _T_479 | _GEN_158; // @[Mux.scala 27:72]
  wire [63:0] _GEN_159 = {{32'd0}, _T_397}; // @[Mux.scala 27:72]
  wire [63:0] _T_481 = _T_480 | _GEN_159; // @[Mux.scala 27:72]
  wire [63:0] _GEN_160 = {{32'd0}, _T_398}; // @[Mux.scala 27:72]
  wire [63:0] _T_482 = _T_481 | _GEN_160; // @[Mux.scala 27:72]
  wire [63:0] _GEN_161 = {{32'd0}, _T_400}; // @[Mux.scala 27:72]
  wire [63:0] _T_484 = _T_482 | _GEN_161; // @[Mux.scala 27:72]
  wire [63:0] _GEN_162 = {{32'd0}, _T_401}; // @[Mux.scala 27:72]
  wire [63:0] _T_485 = _T_484 | _GEN_162; // @[Mux.scala 27:72]
  wire [63:0] _GEN_163 = {{32'd0}, _T_402}; // @[Mux.scala 27:72]
  wire [63:0] _T_486 = _T_485 | _GEN_163; // @[Mux.scala 27:72]
  wire [63:0] _GEN_164 = {{32'd0}, _T_403}; // @[Mux.scala 27:72]
  wire [63:0] _T_487 = _T_486 | _GEN_164; // @[Mux.scala 27:72]
  wire [63:0] _GEN_165 = {{24'd0}, _T_404}; // @[Mux.scala 27:72]
  wire [63:0] _T_488 = _T_487 | _GEN_165; // @[Mux.scala 27:72]
  wire [63:0] _GEN_166 = {{24'd0}, _T_405}; // @[Mux.scala 27:72]
  wire [63:0] _T_489 = _T_488 | _GEN_166; // @[Mux.scala 27:72]
  wire [63:0] _GEN_167 = {{24'd0}, _T_406}; // @[Mux.scala 27:72]
  wire [63:0] _T_490 = _T_489 | _GEN_167; // @[Mux.scala 27:72]
  wire [63:0] _GEN_168 = {{24'd0}, _T_407}; // @[Mux.scala 27:72]
  wire [63:0] _T_491 = _T_490 | _GEN_168; // @[Mux.scala 27:72]
  wire [63:0] _GEN_169 = {{24'd0}, _T_408}; // @[Mux.scala 27:72]
  wire [63:0] _T_492 = _T_491 | _GEN_169; // @[Mux.scala 27:72]
  wire [63:0] _GEN_170 = {{24'd0}, _T_409}; // @[Mux.scala 27:72]
  wire [63:0] _T_493 = _T_492 | _GEN_170; // @[Mux.scala 27:72]
  wire [63:0] _GEN_171 = {{24'd0}, _T_410}; // @[Mux.scala 27:72]
  wire [63:0] _T_494 = _T_493 | _GEN_171; // @[Mux.scala 27:72]
  wire [63:0] _GEN_172 = {{24'd0}, _T_411}; // @[Mux.scala 27:72]
  wire [63:0] _T_495 = _T_494 | _GEN_172; // @[Mux.scala 27:72]
  wire [63:0] _GEN_173 = {{24'd0}, _T_412}; // @[Mux.scala 27:72]
  wire [63:0] _T_496 = _T_495 | _GEN_173; // @[Mux.scala 27:72]
  wire [63:0] _GEN_174 = {{24'd0}, _T_413}; // @[Mux.scala 27:72]
  wire [63:0] _T_497 = _T_496 | _GEN_174; // @[Mux.scala 27:72]
  wire [63:0] _GEN_175 = {{24'd0}, _T_414}; // @[Mux.scala 27:72]
  wire [63:0] _T_498 = _T_497 | _GEN_175; // @[Mux.scala 27:72]
  wire [63:0] _GEN_176 = {{24'd0}, _T_415}; // @[Mux.scala 27:72]
  wire [63:0] _T_499 = _T_498 | _GEN_176; // @[Mux.scala 27:72]
  wire [63:0] _GEN_177 = {{24'd0}, _T_416}; // @[Mux.scala 27:72]
  wire [63:0] _T_500 = _T_499 | _GEN_177; // @[Mux.scala 27:72]
  wire [63:0] _GEN_178 = {{24'd0}, _T_417}; // @[Mux.scala 27:72]
  wire [63:0] _T_501 = _T_500 | _GEN_178; // @[Mux.scala 27:72]
  wire [63:0] _GEN_179 = {{24'd0}, _T_418}; // @[Mux.scala 27:72]
  wire [63:0] _T_502 = _T_501 | _GEN_179; // @[Mux.scala 27:72]
  wire [63:0] _GEN_180 = {{24'd0}, _T_419}; // @[Mux.scala 27:72]
  wire [63:0] _T_503 = _T_502 | _GEN_180; // @[Mux.scala 27:72]
  wire [63:0] _GEN_181 = {{24'd0}, _T_420}; // @[Mux.scala 27:72]
  wire [63:0] _T_504 = _T_503 | _GEN_181; // @[Mux.scala 27:72]
  wire [63:0] _GEN_182 = {{24'd0}, _T_421}; // @[Mux.scala 27:72]
  wire [63:0] _T_505 = _T_504 | _GEN_182; // @[Mux.scala 27:72]
  wire [63:0] _GEN_183 = {{24'd0}, _T_422}; // @[Mux.scala 27:72]
  wire [63:0] _T_506 = _T_505 | _GEN_183; // @[Mux.scala 27:72]
  wire [63:0] _GEN_184 = {{24'd0}, _T_423}; // @[Mux.scala 27:72]
  wire [63:0] _T_507 = _T_506 | _GEN_184; // @[Mux.scala 27:72]
  wire [63:0] _GEN_185 = {{24'd0}, _T_424}; // @[Mux.scala 27:72]
  wire [63:0] _T_508 = _T_507 | _GEN_185; // @[Mux.scala 27:72]
  wire [63:0] _GEN_186 = {{24'd0}, _T_425}; // @[Mux.scala 27:72]
  wire [63:0] _T_509 = _T_508 | _GEN_186; // @[Mux.scala 27:72]
  wire [63:0] _GEN_187 = {{24'd0}, _T_426}; // @[Mux.scala 27:72]
  wire [63:0] _T_510 = _T_509 | _GEN_187; // @[Mux.scala 27:72]
  wire [63:0] _GEN_188 = {{24'd0}, _T_427}; // @[Mux.scala 27:72]
  wire [63:0] _T_511 = _T_510 | _GEN_188; // @[Mux.scala 27:72]
  wire [63:0] _GEN_189 = {{24'd0}, _T_428}; // @[Mux.scala 27:72]
  wire [63:0] _T_512 = _T_511 | _GEN_189; // @[Mux.scala 27:72]
  wire [63:0] _GEN_190 = {{24'd0}, _T_429}; // @[Mux.scala 27:72]
  wire [63:0] _T_513 = _T_512 | _GEN_190; // @[Mux.scala 27:72]
  wire [63:0] _GEN_191 = {{24'd0}, _T_430}; // @[Mux.scala 27:72]
  wire [63:0] _T_514 = _T_513 | _GEN_191; // @[Mux.scala 27:72]
  wire [63:0] _GEN_192 = {{24'd0}, _T_431}; // @[Mux.scala 27:72]
  wire [63:0] _T_515 = _T_514 | _GEN_192; // @[Mux.scala 27:72]
  wire [63:0] _GEN_193 = {{24'd0}, _T_432}; // @[Mux.scala 27:72]
  wire [63:0] _T_516 = _T_515 | _GEN_193; // @[Mux.scala 27:72]
  wire [63:0] _GEN_194 = {{24'd0}, _T_433}; // @[Mux.scala 27:72]
  wire [63:0] _T_517 = _T_516 | _GEN_194; // @[Mux.scala 27:72]
  wire [63:0] _GEN_195 = {{24'd0}, _T_434}; // @[Mux.scala 27:72]
  wire [63:0] _T_518 = _T_517 | _GEN_195; // @[Mux.scala 27:72]
  wire [63:0] _GEN_196 = {{24'd0}, _T_435}; // @[Mux.scala 27:72]
  wire [63:0] _T_519 = _T_518 | _GEN_196; // @[Mux.scala 27:72]
  wire [63:0] _GEN_197 = {{24'd0}, _T_436}; // @[Mux.scala 27:72]
  wire [63:0] _T_520 = _T_519 | _GEN_197; // @[Mux.scala 27:72]
  wire [63:0] _GEN_198 = {{24'd0}, _T_437}; // @[Mux.scala 27:72]
  wire [63:0] _T_521 = _T_520 | _GEN_198; // @[Mux.scala 27:72]
  wire [63:0] _GEN_199 = {{24'd0}, _T_438}; // @[Mux.scala 27:72]
  wire [63:0] _T_522 = _T_521 | _GEN_199; // @[Mux.scala 27:72]
  wire [63:0] _GEN_200 = {{24'd0}, _T_439}; // @[Mux.scala 27:72]
  wire [63:0] _T_523 = _T_522 | _GEN_200; // @[Mux.scala 27:72]
  wire [63:0] _GEN_201 = {{24'd0}, _T_440}; // @[Mux.scala 27:72]
  wire [63:0] _T_524 = _T_523 | _GEN_201; // @[Mux.scala 27:72]
  wire [63:0] _GEN_202 = {{24'd0}, _T_441}; // @[Mux.scala 27:72]
  wire [63:0] _T_525 = _T_524 | _GEN_202; // @[Mux.scala 27:72]
  wire [63:0] _GEN_203 = {{24'd0}, _T_442}; // @[Mux.scala 27:72]
  wire [63:0] _T_526 = _T_525 | _GEN_203; // @[Mux.scala 27:72]
  wire [63:0] _GEN_204 = {{24'd0}, _T_443}; // @[Mux.scala 27:72]
  wire [63:0] _T_527 = _T_526 | _GEN_204; // @[Mux.scala 27:72]
  wire [63:0] _GEN_205 = {{24'd0}, _T_444}; // @[Mux.scala 27:72]
  wire [63:0] _T_528 = _T_527 | _GEN_205; // @[Mux.scala 27:72]
  wire [63:0] _GEN_206 = {{24'd0}, _T_445}; // @[Mux.scala 27:72]
  wire [63:0] _T_529 = _T_528 | _GEN_206; // @[Mux.scala 27:72]
  wire [63:0] _GEN_207 = {{24'd0}, _T_446}; // @[Mux.scala 27:72]
  wire [63:0] _T_530 = _T_529 | _GEN_207; // @[Mux.scala 27:72]
  wire [63:0] _GEN_208 = {{24'd0}, _T_447}; // @[Mux.scala 27:72]
  wire [63:0] _T_531 = _T_530 | _GEN_208; // @[Mux.scala 27:72]
  wire [63:0] _GEN_209 = {{24'd0}, _T_448}; // @[Mux.scala 27:72]
  wire [63:0] _T_532 = _T_531 | _GEN_209; // @[Mux.scala 27:72]
  wire [63:0] _GEN_210 = {{24'd0}, _T_449}; // @[Mux.scala 27:72]
  wire [63:0] _T_533 = _T_532 | _GEN_210; // @[Mux.scala 27:72]
  wire [63:0] _GEN_211 = {{24'd0}, _T_450}; // @[Mux.scala 27:72]
  wire [63:0] _T_534 = _T_533 | _GEN_211; // @[Mux.scala 27:72]
  wire [63:0] _GEN_212 = {{24'd0}, _T_451}; // @[Mux.scala 27:72]
  wire [63:0] _T_535 = _T_534 | _GEN_212; // @[Mux.scala 27:72]
  wire [63:0] _GEN_213 = {{24'd0}, _T_452}; // @[Mux.scala 27:72]
  wire [63:0] _T_536 = _T_535 | _GEN_213; // @[Mux.scala 27:72]
  wire [63:0] _GEN_214 = {{24'd0}, _T_453}; // @[Mux.scala 27:72]
  wire [63:0] _T_537 = _T_536 | _GEN_214; // @[Mux.scala 27:72]
  wire [63:0] _GEN_215 = {{24'd0}, _T_454}; // @[Mux.scala 27:72]
  wire [63:0] _T_538 = _T_537 | _GEN_215; // @[Mux.scala 27:72]
  wire [63:0] _GEN_216 = {{24'd0}, _T_455}; // @[Mux.scala 27:72]
  wire [63:0] _T_539 = _T_538 | _GEN_216; // @[Mux.scala 27:72]
  wire [63:0] _GEN_217 = {{24'd0}, _T_456}; // @[Mux.scala 27:72]
  wire [63:0] _T_540 = _T_539 | _GEN_217; // @[Mux.scala 27:72]
  wire [63:0] _GEN_218 = {{24'd0}, _T_457}; // @[Mux.scala 27:72]
  wire [63:0] _T_541 = _T_540 | _GEN_218; // @[Mux.scala 27:72]
  wire [63:0] _GEN_219 = {{24'd0}, _T_458}; // @[Mux.scala 27:72]
  wire [63:0] _T_542 = _T_541 | _GEN_219; // @[Mux.scala 27:72]
  wire [63:0] _GEN_220 = {{24'd0}, _T_459}; // @[Mux.scala 27:72]
  wire [63:0] _T_543 = _T_542 | _GEN_220; // @[Mux.scala 27:72]
  wire [63:0] _GEN_221 = {{24'd0}, _T_460}; // @[Mux.scala 27:72]
  wire [63:0] _T_544 = _T_543 | _GEN_221; // @[Mux.scala 27:72]
  wire [63:0] _GEN_222 = {{24'd0}, _T_461}; // @[Mux.scala 27:72]
  wire [63:0] _T_545 = _T_544 | _GEN_222; // @[Mux.scala 27:72]
  wire [63:0] _GEN_223 = {{24'd0}, _T_462}; // @[Mux.scala 27:72]
  wire [63:0] _T_546 = _T_545 | _GEN_223; // @[Mux.scala 27:72]
  wire [63:0] _GEN_224 = {{24'd0}, _T_463}; // @[Mux.scala 27:72]
  wire [63:0] _T_547 = _T_546 | _GEN_224; // @[Mux.scala 27:72]
  wire [63:0] _GEN_225 = {{24'd0}, _T_464}; // @[Mux.scala 27:72]
  wire [63:0] _T_548 = _T_547 | _GEN_225; // @[Mux.scala 27:72]
  wire [63:0] _GEN_226 = {{24'd0}, _T_465}; // @[Mux.scala 27:72]
  wire [63:0] _T_549 = _T_548 | _GEN_226; // @[Mux.scala 27:72]
  wire [63:0] _GEN_227 = {{24'd0}, _T_466}; // @[Mux.scala 27:72]
  wire [63:0] _T_550 = _T_549 | _GEN_227; // @[Mux.scala 27:72]
  wire [63:0] _GEN_228 = {{24'd0}, _T_467}; // @[Mux.scala 27:72]
  wire [63:0] _T_551 = _T_550 | _GEN_228; // @[Mux.scala 27:72]
  wire [34:0] _WIRE_8 = {{3'd0}, wdata};
  wire [39:0] _T_626 = {wdata[7:0],REG_4[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_21 = _T_95 ? {{1'd0}, _T_626} : _T_10; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_628 = {REG_4[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_22 = _T_94 ? {{1'd0}, _T_628} : _GEN_21; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_631 = {wdata[7:0],REG_5[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_23 = _T_97 ? {{1'd0}, _T_631} : _T_11; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_633 = {REG_5[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_24 = _T_96 ? {{1'd0}, _T_633} : _GEN_23; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_636 = {wdata[7:0],REG_6[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_25 = _T_99 ? {{1'd0}, _T_636} : _T_12; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_638 = {REG_6[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_26 = _T_98 ? {{1'd0}, _T_638} : _GEN_25; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_641 = {wdata[7:0],REG_7[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_27 = _T_101 ? {{1'd0}, _T_641} : _T_13; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_643 = {REG_7[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_28 = _T_100 ? {{1'd0}, _T_643} : _GEN_27; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_646 = {wdata[7:0],REG_8[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_29 = _T_103 ? {{1'd0}, _T_646} : _T_14; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_648 = {REG_8[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_30 = _T_102 ? {{1'd0}, _T_648} : _GEN_29; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_651 = {wdata[7:0],REG_9[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_31 = _T_105 ? {{1'd0}, _T_651} : _T_15; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_653 = {REG_9[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_32 = _T_104 ? {{1'd0}, _T_653} : _GEN_31; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_656 = {wdata[7:0],REG_10[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_33 = _T_107 ? {{1'd0}, _T_656} : _T_16; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_658 = {REG_10[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_34 = _T_106 ? {{1'd0}, _T_658} : _GEN_33; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_661 = {wdata[7:0],REG_11[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_35 = _T_109 ? {{1'd0}, _T_661} : _T_17; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_663 = {REG_11[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_36 = _T_108 ? {{1'd0}, _T_663} : _GEN_35; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_666 = {wdata[7:0],REG_12[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_37 = _T_111 ? {{1'd0}, _T_666} : _T_18; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_668 = {REG_12[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_38 = _T_110 ? {{1'd0}, _T_668} : _GEN_37; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_671 = {wdata[7:0],REG_13[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_39 = _T_113 ? {{1'd0}, _T_671} : _T_19; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_673 = {REG_13[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_40 = _T_112 ? {{1'd0}, _T_673} : _GEN_39; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_676 = {wdata[7:0],REG_14[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_41 = _T_115 ? {{1'd0}, _T_676} : _T_20; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_678 = {REG_14[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_42 = _T_114 ? {{1'd0}, _T_678} : _GEN_41; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_681 = {wdata[7:0],REG_15[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_43 = _T_117 ? {{1'd0}, _T_681} : _T_21; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_683 = {REG_15[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_44 = _T_116 ? {{1'd0}, _T_683} : _GEN_43; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_686 = {wdata[7:0],REG_16[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_45 = _T_119 ? {{1'd0}, _T_686} : _T_22; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_688 = {REG_16[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_46 = _T_118 ? {{1'd0}, _T_688} : _GEN_45; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_691 = {wdata[7:0],REG_17[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_47 = _T_121 ? {{1'd0}, _T_691} : _T_23; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_693 = {REG_17[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_48 = _T_120 ? {{1'd0}, _T_693} : _GEN_47; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_696 = {wdata[7:0],REG_18[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_49 = _T_123 ? {{1'd0}, _T_696} : _T_24; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_698 = {REG_18[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_50 = _T_122 ? {{1'd0}, _T_698} : _GEN_49; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_701 = {wdata[7:0],REG_19[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_51 = _T_125 ? {{1'd0}, _T_701} : _T_25; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_703 = {REG_19[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_52 = _T_124 ? {{1'd0}, _T_703} : _GEN_51; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_706 = {wdata[7:0],REG_20[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_53 = _T_127 ? {{1'd0}, _T_706} : _T_26; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_708 = {REG_20[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_54 = _T_126 ? {{1'd0}, _T_708} : _GEN_53; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_711 = {wdata[7:0],REG_21[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_55 = _T_129 ? {{1'd0}, _T_711} : _T_27; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_713 = {REG_21[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_56 = _T_128 ? {{1'd0}, _T_713} : _GEN_55; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_716 = {wdata[7:0],REG_22[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_57 = _T_131 ? {{1'd0}, _T_716} : _T_28; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_718 = {REG_22[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_58 = _T_130 ? {{1'd0}, _T_718} : _GEN_57; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_721 = {wdata[7:0],REG_23[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_59 = _T_133 ? {{1'd0}, _T_721} : _T_29; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_723 = {REG_23[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_60 = _T_132 ? {{1'd0}, _T_723} : _GEN_59; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_726 = {wdata[7:0],REG_24[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_61 = _T_135 ? {{1'd0}, _T_726} : _T_30; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_728 = {REG_24[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_62 = _T_134 ? {{1'd0}, _T_728} : _GEN_61; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_731 = {wdata[7:0],REG_25[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_63 = _T_137 ? {{1'd0}, _T_731} : _T_31; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_733 = {REG_25[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_64 = _T_136 ? {{1'd0}, _T_733} : _GEN_63; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_736 = {wdata[7:0],REG_26[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_65 = _T_139 ? {{1'd0}, _T_736} : _T_32; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_738 = {REG_26[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_66 = _T_138 ? {{1'd0}, _T_738} : _GEN_65; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_741 = {wdata[7:0],REG_27[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_67 = _T_141 ? {{1'd0}, _T_741} : _T_33; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_743 = {REG_27[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_68 = _T_140 ? {{1'd0}, _T_743} : _GEN_67; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_746 = {wdata[7:0],REG_28[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_69 = _T_143 ? {{1'd0}, _T_746} : _T_34; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_748 = {REG_28[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_70 = _T_142 ? {{1'd0}, _T_748} : _GEN_69; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_751 = {wdata[7:0],REG_29[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_71 = _T_145 ? {{1'd0}, _T_751} : _T_35; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_753 = {REG_29[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_72 = _T_144 ? {{1'd0}, _T_753} : _GEN_71; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_756 = {wdata[7:0],REG_30[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_73 = _T_147 ? {{1'd0}, _T_756} : _T_36; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_758 = {REG_30[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_74 = _T_146 ? {{1'd0}, _T_758} : _GEN_73; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_761 = {wdata[7:0],REG_31[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_75 = _T_149 ? {{1'd0}, _T_761} : _T_37; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_763 = {REG_31[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_76 = _T_148 ? {{1'd0}, _T_763} : _GEN_75; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_766 = {wdata[7:0],REG_32[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_77 = _T_151 ? {{1'd0}, _T_766} : _T_38; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_768 = {REG_32[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_78 = _T_150 ? {{1'd0}, _T_768} : _GEN_77; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_771 = {wdata[7:0],REG_33[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_79 = _T_153 ? {{1'd0}, _T_771} : _T_39; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_773 = {REG_33[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_80 = _T_152 ? {{1'd0}, _T_773} : _GEN_79; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_776 = {wdata[7:0],REG_34[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_81 = _T_155 ? {{1'd0}, _T_776} : _T_40; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_778 = {REG_34[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_82 = _T_154 ? {{1'd0}, _T_778} : _GEN_81; // @[csr.scala 391:29 util.scala 134:11]
  wire [39:0] _T_781 = {wdata[7:0],REG_35[31:0]}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_83 = _T_157 ? {{1'd0}, _T_781} : _T_41; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [39:0] _T_783 = {REG_35[39:32],wdata}; // @[Cat.scala 30:58]
  wire [40:0] _GEN_84 = _T_156 ? {{1'd0}, _T_783} : _GEN_83; // @[csr.scala 391:29 util.scala 134:11]
  wire [63:0] _T_786 = {wdata,_T_4[31:0]}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_85 = _T_158 ? _T_786 : {{57'd0}, _T}; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [63:0] _T_789 = {_T_4[63:32],wdata}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_87 = _T_75 ? _T_789 : _GEN_85; // @[csr.scala 391:29 util.scala 134:11]
  wire [63:0] _T_793 = {wdata,_T_9[31:0]}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_89 = _T_159 ? _T_793 : {{57'd0}, _T_5}; // @[csr.scala 390:29 util.scala 134:11 util.scala 116:9]
  wire [63:0] _T_796 = {_T_9[63:32],wdata}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_91 = _T_76 ? _T_796 : _GEN_89; // @[csr.scala 391:29 util.scala 134:11]
  wire [31:0] _T_799 = {{2'd0}, wdata[31:2]}; // @[csr.scala 372:78]
  wire [33:0] _GEN_230 = {_T_799, 2'h0}; // @[csr.scala 372:86]
  wire [34:0] _T_800 = {{1'd0}, _GEN_230}; // @[csr.scala 372:86]
  wire [34:0] _GEN_95 = _T_86 ? _T_800 : {{3'd0}, _GEN_13}; // @[csr.scala 372:40 csr.scala 372:51]
  wire [31:0] _T_801 = wdata & 32'h8000001f; // @[csr.scala 374:62]
  wire [40:0] _GEN_107 = wen ? _GEN_22 : _T_10; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_108 = wen ? _GEN_24 : _T_11; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_109 = wen ? _GEN_26 : _T_12; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_110 = wen ? _GEN_28 : _T_13; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_111 = wen ? _GEN_30 : _T_14; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_112 = wen ? _GEN_32 : _T_15; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_113 = wen ? _GEN_34 : _T_16; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_114 = wen ? _GEN_36 : _T_17; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_115 = wen ? _GEN_38 : _T_18; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_116 = wen ? _GEN_40 : _T_19; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_117 = wen ? _GEN_42 : _T_20; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_118 = wen ? _GEN_44 : _T_21; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_119 = wen ? _GEN_46 : _T_22; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_120 = wen ? _GEN_48 : _T_23; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_121 = wen ? _GEN_50 : _T_24; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_122 = wen ? _GEN_52 : _T_25; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_123 = wen ? _GEN_54 : _T_26; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_124 = wen ? _GEN_56 : _T_27; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_125 = wen ? _GEN_58 : _T_28; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_126 = wen ? _GEN_60 : _T_29; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_127 = wen ? _GEN_62 : _T_30; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_128 = wen ? _GEN_64 : _T_31; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_129 = wen ? _GEN_66 : _T_32; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_130 = wen ? _GEN_68 : _T_33; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_131 = wen ? _GEN_70 : _T_34; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_132 = wen ? _GEN_72 : _T_35; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_133 = wen ? _GEN_74 : _T_36; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_134 = wen ? _GEN_76 : _T_37; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_135 = wen ? _GEN_78 : _T_38; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_136 = wen ? _GEN_80 : _T_39; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_137 = wen ? _GEN_82 : _T_40; // @[csr.scala 335:14 util.scala 116:9]
  wire [40:0] _GEN_138 = wen ? _GEN_84 : _T_41; // @[csr.scala 335:14 util.scala 116:9]
  wire [63:0] _GEN_139 = wen ? _GEN_87 : {{57'd0}, _T}; // @[csr.scala 335:14 util.scala 116:9]
  wire [63:0] _GEN_141 = wen ? _GEN_91 : {{57'd0}, _T_5}; // @[csr.scala 335:14 util.scala 116:9]
  wire [34:0] _GEN_145 = wen ? _GEN_95 : {{3'd0}, _GEN_13}; // @[csr.scala 335:14]
  assign io_rw_rdata = _T_551[31:0]; // @[csr.scala 333:15]
  assign io_eret = insn_call | insn_break | insn_ret; // @[csr.scala 282:38]
  assign io_status_debug = 1'h0; // @[csr.scala 280:13]
  assign io_status_prv = 2'h3; // @[csr.scala 280:13]
  assign io_status_sd = 1'h0; // @[csr.scala 280:13]
  assign io_status_zero1 = 8'h0; // @[csr.scala 280:13]
  assign io_status_tsr = 1'h0; // @[csr.scala 280:13]
  assign io_status_tw = 1'h0; // @[csr.scala 280:13]
  assign io_status_tvm = 1'h0; // @[csr.scala 280:13]
  assign io_status_mxr = 1'h0; // @[csr.scala 280:13]
  assign io_status_sum = 1'h0; // @[csr.scala 280:13]
  assign io_status_mprv = 1'h0; // @[csr.scala 280:13]
  assign io_status_xs = 2'h0; // @[csr.scala 280:13]
  assign io_status_fs = 2'h0; // @[csr.scala 280:13]
  assign io_status_mpp = 2'h3; // @[csr.scala 280:13]
  assign io_status_hpp = 2'h0; // @[csr.scala 280:13]
  assign io_status_spp = 1'h0; // @[csr.scala 280:13]
  assign io_status_mpie = reg_mstatus_mpie; // @[csr.scala 280:13]
  assign io_status_hpie = 1'h0; // @[csr.scala 280:13]
  assign io_status_spie = 1'h0; // @[csr.scala 280:13]
  assign io_status_upie = 1'h0; // @[csr.scala 280:13]
  assign io_status_mie = reg_mstatus_mie; // @[csr.scala 280:13]
  assign io_status_hie = 1'h0; // @[csr.scala 280:13]
  assign io_status_sie = 1'h0; // @[csr.scala 280:13]
  assign io_status_uie = 1'h0; // @[csr.scala 280:13]
  assign io_evec = insn_ret & ~io_decode_csr[10] ? reg_mepc : _GEN_6; // @[csr.scala 308:41 csr.scala 312:13]
  assign io_time = _T_4[31:0]; // @[csr.scala 329:11]
  always @(posedge clock) begin
    if (reset) begin // @[csr.scala 163:28]
      reg_mstatus_mpie <= 1'h0; // @[csr.scala 163:28]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_81) begin // @[csr.scala 344:39]
        reg_mstatus_mpie <= _WIRE_8[7]; // @[csr.scala 347:24]
      end else begin
        reg_mstatus_mpie <= _GEN_8;
      end
    end else begin
      reg_mstatus_mpie <= _GEN_8;
    end
    if (reset) begin // @[csr.scala 163:28]
      reg_mstatus_mie <= 1'h0; // @[csr.scala 163:28]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_81) begin // @[csr.scala 344:39]
        reg_mstatus_mie <= _WIRE_8[3]; // @[csr.scala 346:23]
      end else begin
        reg_mstatus_mie <= _GEN_7;
      end
    end else begin
      reg_mstatus_mie <= _GEN_7;
    end
    reg_mepc <= _GEN_145[31:0];
    if (wen) begin // @[csr.scala 335:14]
      if (_T_88) begin // @[csr.scala 374:40]
        reg_mcause <= _T_801; // @[csr.scala 374:53]
      end else begin
        reg_mcause <= _GEN_12;
      end
    end else begin
      reg_mcause <= _GEN_12;
    end
    if (wen) begin // @[csr.scala 335:14]
      if (_T_87) begin // @[csr.scala 375:40]
        reg_mtval <= wdata; // @[csr.scala 375:52]
      end
    end
    if (wen) begin // @[csr.scala 335:14]
      if (_T_85) begin // @[csr.scala 373:40]
        reg_mscratch <= wdata; // @[csr.scala 373:55]
      end
    end
    if (wen) begin // @[csr.scala 335:14]
      if (_T_93) begin // @[csr.scala 376:42]
        reg_medeleg <= wdata; // @[csr.scala 376:56]
      end
    end
    if (reset) begin // @[csr.scala 171:24]
      reg_mip_mtip <= 1'h0; // @[csr.scala 171:24]
    end else begin
      reg_mip_mtip <= 1'h1;
    end
    if (reset) begin // @[csr.scala 171:24]
      reg_mip_msip <= 1'h0; // @[csr.scala 171:24]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_83) begin // @[csr.scala 349:35]
        reg_mip_msip <= wdata[3]; // @[csr.scala 351:20]
      end
    end
    if (reset) begin // @[csr.scala 172:24]
      reg_mie_mtip <= 1'h0; // @[csr.scala 172:24]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_84) begin // @[csr.scala 353:35]
        reg_mie_mtip <= wdata[7]; // @[csr.scala 356:20]
      end
    end
    if (reset) begin // @[csr.scala 172:24]
      reg_mie_msip <= 1'h0; // @[csr.scala 172:24]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_84) begin // @[csr.scala 353:35]
        reg_mie_msip <= wdata[3]; // @[csr.scala 355:20]
      end
    end
    if (reset) begin // @[util.scala 114:41]
      REG <= 6'h0; // @[util.scala 114:41]
    end else begin
      REG <= _GEN_139[5:0];
    end
    if (reset) begin // @[util.scala 119:31]
      REG_1 <= 58'h0; // @[util.scala 119:31]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_75) begin // @[csr.scala 391:29]
        REG_1 <= _T_789[63:6]; // @[util.scala 135:23]
      end else if (_T_158) begin // @[csr.scala 390:29]
        REG_1 <= _T_786[63:6]; // @[util.scala 135:23]
      end else begin
        REG_1 <= _GEN_0;
      end
    end else begin
      REG_1 <= _GEN_0;
    end
    if (reset) begin // @[util.scala 114:41]
      REG_2 <= 6'h0; // @[util.scala 114:41]
    end else begin
      REG_2 <= _GEN_141[5:0];
    end
    if (reset) begin // @[util.scala 119:31]
      REG_3 <= 58'h0; // @[util.scala 119:31]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_76) begin // @[csr.scala 391:29]
        REG_3 <= _T_796[63:6]; // @[util.scala 135:23]
      end else if (_T_159) begin // @[csr.scala 390:29]
        REG_3 <= _T_793[63:6]; // @[util.scala 135:23]
      end else begin
        REG_3 <= _GEN_1;
      end
    end else begin
      REG_3 <= _GEN_1;
    end
    REG_4 <= _GEN_107[39:0];
    REG_5 <= _GEN_108[39:0];
    REG_6 <= _GEN_109[39:0];
    REG_7 <= _GEN_110[39:0];
    REG_8 <= _GEN_111[39:0];
    REG_9 <= _GEN_112[39:0];
    REG_10 <= _GEN_113[39:0];
    REG_11 <= _GEN_114[39:0];
    REG_12 <= _GEN_115[39:0];
    REG_13 <= _GEN_116[39:0];
    REG_14 <= _GEN_117[39:0];
    REG_15 <= _GEN_118[39:0];
    REG_16 <= _GEN_119[39:0];
    REG_17 <= _GEN_120[39:0];
    REG_18 <= _GEN_121[39:0];
    REG_19 <= _GEN_122[39:0];
    REG_20 <= _GEN_123[39:0];
    REG_21 <= _GEN_124[39:0];
    REG_22 <= _GEN_125[39:0];
    REG_23 <= _GEN_126[39:0];
    REG_24 <= _GEN_127[39:0];
    REG_25 <= _GEN_128[39:0];
    REG_26 <= _GEN_129[39:0];
    REG_27 <= _GEN_130[39:0];
    REG_28 <= _GEN_131[39:0];
    REG_29 <= _GEN_132[39:0];
    REG_30 <= _GEN_133[39:0];
    REG_31 <= _GEN_134[39:0];
    REG_32 <= _GEN_135[39:0];
    REG_33 <= _GEN_136[39:0];
    REG_34 <= _GEN_137[39:0];
    REG_35 <= _GEN_138[39:0];
    if (wen) begin // @[csr.scala 335:14]
      if (_T_91) begin // @[csr.scala 369:40]
        reg_dpc <= wdata; // @[csr.scala 369:50]
      end
    end
    if (wen) begin // @[csr.scala 335:14]
      if (_T_92) begin // @[csr.scala 370:40]
        reg_dscratch <= wdata; // @[csr.scala 370:55]
      end
    end
    if (reset) begin // @[csr.scala 194:25]
      reg_dcsr_ebreakm <= 1'h0; // @[csr.scala 194:25]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_90) begin // @[csr.scala 337:36]
        reg_dcsr_ebreakm <= wdata[15]; // @[csr.scala 340:26]
      end
    end
    if (reset) begin // @[csr.scala 194:25]
      reg_dcsr_step <= 1'h0; // @[csr.scala 194:25]
    end else if (wen) begin // @[csr.scala 335:14]
      if (_T_90) begin // @[csr.scala 337:36]
        reg_dcsr_step <= wdata[2]; // @[csr.scala 339:23]
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~(_T_369 <= 2'h1 | reset)) begin
          $fwrite(32'h80000002,
            "Assertion failed: these conditions must be mutually exclusive\n    at csr.scala:290 assert(PopCount(insn_ret :: io.exception :: Nil) <= 1, \"these conditions must be mutually exclusive\")\n"
            ); // @[csr.scala 290:9]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (~(_T_369 <= 2'h1 | reset)) begin
          $fatal; // @[csr.scala 290:9]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_mstatus_mpie = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  reg_mstatus_mie = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  reg_mepc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_mcause = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_mtval = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg_mscratch = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_medeleg = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_mip_mtip = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  reg_mip_msip = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  reg_mie_mtip = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  reg_mie_msip = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  REG = _RAND_11[5:0];
  _RAND_12 = {2{`RANDOM}};
  REG_1 = _RAND_12[57:0];
  _RAND_13 = {1{`RANDOM}};
  REG_2 = _RAND_13[5:0];
  _RAND_14 = {2{`RANDOM}};
  REG_3 = _RAND_14[57:0];
  _RAND_15 = {2{`RANDOM}};
  REG_4 = _RAND_15[39:0];
  _RAND_16 = {2{`RANDOM}};
  REG_5 = _RAND_16[39:0];
  _RAND_17 = {2{`RANDOM}};
  REG_6 = _RAND_17[39:0];
  _RAND_18 = {2{`RANDOM}};
  REG_7 = _RAND_18[39:0];
  _RAND_19 = {2{`RANDOM}};
  REG_8 = _RAND_19[39:0];
  _RAND_20 = {2{`RANDOM}};
  REG_9 = _RAND_20[39:0];
  _RAND_21 = {2{`RANDOM}};
  REG_10 = _RAND_21[39:0];
  _RAND_22 = {2{`RANDOM}};
  REG_11 = _RAND_22[39:0];
  _RAND_23 = {2{`RANDOM}};
  REG_12 = _RAND_23[39:0];
  _RAND_24 = {2{`RANDOM}};
  REG_13 = _RAND_24[39:0];
  _RAND_25 = {2{`RANDOM}};
  REG_14 = _RAND_25[39:0];
  _RAND_26 = {2{`RANDOM}};
  REG_15 = _RAND_26[39:0];
  _RAND_27 = {2{`RANDOM}};
  REG_16 = _RAND_27[39:0];
  _RAND_28 = {2{`RANDOM}};
  REG_17 = _RAND_28[39:0];
  _RAND_29 = {2{`RANDOM}};
  REG_18 = _RAND_29[39:0];
  _RAND_30 = {2{`RANDOM}};
  REG_19 = _RAND_30[39:0];
  _RAND_31 = {2{`RANDOM}};
  REG_20 = _RAND_31[39:0];
  _RAND_32 = {2{`RANDOM}};
  REG_21 = _RAND_32[39:0];
  _RAND_33 = {2{`RANDOM}};
  REG_22 = _RAND_33[39:0];
  _RAND_34 = {2{`RANDOM}};
  REG_23 = _RAND_34[39:0];
  _RAND_35 = {2{`RANDOM}};
  REG_24 = _RAND_35[39:0];
  _RAND_36 = {2{`RANDOM}};
  REG_25 = _RAND_36[39:0];
  _RAND_37 = {2{`RANDOM}};
  REG_26 = _RAND_37[39:0];
  _RAND_38 = {2{`RANDOM}};
  REG_27 = _RAND_38[39:0];
  _RAND_39 = {2{`RANDOM}};
  REG_28 = _RAND_39[39:0];
  _RAND_40 = {2{`RANDOM}};
  REG_29 = _RAND_40[39:0];
  _RAND_41 = {2{`RANDOM}};
  REG_30 = _RAND_41[39:0];
  _RAND_42 = {2{`RANDOM}};
  REG_31 = _RAND_42[39:0];
  _RAND_43 = {2{`RANDOM}};
  REG_32 = _RAND_43[39:0];
  _RAND_44 = {2{`RANDOM}};
  REG_33 = _RAND_44[39:0];
  _RAND_45 = {2{`RANDOM}};
  REG_34 = _RAND_45[39:0];
  _RAND_46 = {2{`RANDOM}};
  REG_35 = _RAND_46[39:0];
  _RAND_47 = {1{`RANDOM}};
  reg_dpc = _RAND_47[31:0];
  _RAND_48 = {1{`RANDOM}};
  reg_dscratch = _RAND_48[31:0];
  _RAND_49 = {1{`RANDOM}};
  reg_dcsr_ebreakm = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  reg_dcsr_step = _RAND_50[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule // CSRFile

module DatPath(
  input         clock,
  input         reset,
  input  [4:0]  io_ddpath_addr,
  input  [31:0] io_ddpath_wdata,
  output [31:0] io_ddpath_rdata,
  output [31:0] io_imem_req_bits_addr,
  input  [31:0] io_imem_resp_bits_data,
  output [31:0] io_dmem_req_bits_addr,
  output [31:0] io_dmem_req_bits_data,
  input  [31:0] io_dmem_resp_bits_data,
  input         io_ctl_stall,
  input  [2:0]  io_ctl_pc_sel,
  input  [1:0]  io_ctl_op1_sel,
  input  [1:0]  io_ctl_op2_sel,
  input  [3:0]  io_ctl_alu_fun,
  input  [1:0]  io_ctl_wb_sel,
  input         io_ctl_rf_wen,
  input  [2:0]  io_ctl_csr_cmd,
  input         io_ctl_exception,
  output [31:0] io_dat_inst,
  output        io_dat_br_eq,
  output        io_dat_br_lt,
  output        io_dat_br_ltu,
  output        io_dat_csr_eret
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regfile [0:31]; // @[dpath.scala 84:21]
  wire [31:0] regfile_MPORT_1_data; // @[dpath.scala 84:21]
  wire [4:0] regfile_MPORT_1_addr; // @[dpath.scala 84:21]
  wire [31:0] regfile_MPORT_3_data; // @[dpath.scala 84:21]
  wire [4:0] regfile_MPORT_3_addr; // @[dpath.scala 84:21]
  wire [31:0] regfile_MPORT_4_data; // @[dpath.scala 84:21]
  wire [4:0] regfile_MPORT_4_addr; // @[dpath.scala 84:21]
  wire [31:0] regfile_MPORT_data; // @[dpath.scala 84:21]
  wire [4:0] regfile_MPORT_addr; // @[dpath.scala 84:21]
  wire  regfile_MPORT_mask; // @[dpath.scala 84:21]
  wire  regfile_MPORT_en; // @[dpath.scala 84:21]
  wire [31:0] regfile_MPORT_2_data; // @[dpath.scala 84:21]
  wire [4:0] regfile_MPORT_2_addr; // @[dpath.scala 84:21]
  wire  regfile_MPORT_2_mask; // @[dpath.scala 84:21]
  wire  regfile_MPORT_2_en; // @[dpath.scala 84:21]
  wire  csr_clock; // @[dpath.scala 158:20]
  wire  csr_reset; // @[dpath.scala 158:20]
  wire [2:0] csr_io_rw_cmd; // @[dpath.scala 158:20]
  wire [31:0] csr_io_rw_rdata; // @[dpath.scala 158:20]
  wire [31:0] csr_io_rw_wdata; // @[dpath.scala 158:20]
  wire  csr_io_eret; // @[dpath.scala 158:20]
  wire [11:0] csr_io_decode_csr; // @[dpath.scala 158:20]
  wire  csr_io_status_debug; // @[dpath.scala 158:20]
  wire [1:0] csr_io_status_prv; // @[dpath.scala 158:20]
  wire  csr_io_status_sd; // @[dpath.scala 158:20]
  wire [7:0] csr_io_status_zero1; // @[dpath.scala 158:20]
  wire  csr_io_status_tsr; // @[dpath.scala 158:20]
  wire  csr_io_status_tw; // @[dpath.scala 158:20]
  wire  csr_io_status_tvm; // @[dpath.scala 158:20]
  wire  csr_io_status_mxr; // @[dpath.scala 158:20]
  wire  csr_io_status_sum; // @[dpath.scala 158:20]
  wire  csr_io_status_mprv; // @[dpath.scala 158:20]
  wire [1:0] csr_io_status_xs; // @[dpath.scala 158:20]
  wire [1:0] csr_io_status_fs; // @[dpath.scala 158:20]
  wire [1:0] csr_io_status_mpp; // @[dpath.scala 158:20]
  wire [1:0] csr_io_status_hpp; // @[dpath.scala 158:20]
  wire  csr_io_status_spp; // @[dpath.scala 158:20]
  wire  csr_io_status_mpie; // @[dpath.scala 158:20]
  wire  csr_io_status_hpie; // @[dpath.scala 158:20]
  wire  csr_io_status_spie; // @[dpath.scala 158:20]
  wire  csr_io_status_upie; // @[dpath.scala 158:20]
  wire  csr_io_status_mie; // @[dpath.scala 158:20]
  wire  csr_io_status_hie; // @[dpath.scala 158:20]
  wire  csr_io_status_sie; // @[dpath.scala 158:20]
  wire  csr_io_status_uie; // @[dpath.scala 158:20]
  wire [31:0] csr_io_evec; // @[dpath.scala 158:20]
  wire  csr_io_exception; // @[dpath.scala 158:20]
  wire  csr_io_retire; // @[dpath.scala 158:20]
  wire [31:0] csr_io_pc; // @[dpath.scala 158:20]
  wire [31:0] csr_io_time; // @[dpath.scala 158:20]
  wire  _T = io_ctl_pc_sel == 3'h0; // @[dpath.scala 53:34]
  wire  _T_1 = io_ctl_pc_sel == 3'h1; // @[dpath.scala 54:34]
  wire  _T_2 = io_ctl_pc_sel == 3'h2; // @[dpath.scala 55:34]
  wire  _T_3 = io_ctl_pc_sel == 3'h3; // @[dpath.scala 56:34]
  wire  _T_4 = io_ctl_pc_sel == 3'h4; // @[dpath.scala 57:34]
  wire [31:0] exception_target = csr_io_evec; // @[dpath.scala 49:31 dpath.scala 167:21]
  reg [31:0] pc_reg; // @[dpath.scala 60:24]
  wire [31:0] pc_plus4 = pc_reg + 32'h4; // @[dpath.scala 67:24]
  wire [31:0] _T_5 = _T_4 ? exception_target : pc_plus4; // @[Mux.scala 98:16]
  wire [4:0] rs1_addr = io_imem_resp_bits_data[19:15]; // @[dpath.scala 76:23]
  wire [31:0] rs1_data = rs1_addr != 5'h0 ? regfile_MPORT_3_data : 32'h0; // @[dpath.scala 98:22]
  wire [11:0] imm_i = io_imem_resp_bits_data[31:20]; // @[dpath.scala 103:20]
  wire [19:0] _T_32 = imm_i[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] imm_i_sext = {_T_32,imm_i}; // @[Cat.scala 30:58]
  wire [31:0] jump_reg_target = rs1_data + imm_i_sext; // @[dpath.scala 155:42]
  wire [31:0] _T_6 = _T_3 ? jump_reg_target : _T_5; // @[Mux.scala 98:16]
  wire [19:0] imm_j = {io_imem_resp_bits_data[31],io_imem_resp_bits_data[19:12],io_imem_resp_bits_data[20],
    io_imem_resp_bits_data[30:21]}; // @[Cat.scala 30:58]
  wire [10:0] _T_42 = imm_j[19] ? 11'h7ff : 11'h0; // @[Bitwise.scala 72:12]
  wire [31:0] imm_j_sext = {_T_42,io_imem_resp_bits_data[31],io_imem_resp_bits_data[19:12],io_imem_resp_bits_data[20],
    io_imem_resp_bits_data[30:21],1'h0}; // @[Cat.scala 30:58]
  wire [31:0] jmp_target = pc_reg + imm_j_sext; // @[dpath.scala 154:30]
  wire [31:0] _T_7 = _T_2 ? jmp_target : _T_6; // @[Mux.scala 98:16]
  wire [11:0] imm_b = {io_imem_resp_bits_data[31],io_imem_resp_bits_data[7],io_imem_resp_bits_data[30:25],
    io_imem_resp_bits_data[11:8]}; // @[Cat.scala 30:58]
  wire [18:0] _T_38 = imm_b[11] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 72:12]
  wire [31:0] imm_b_sext = {_T_38,io_imem_resp_bits_data[31],io_imem_resp_bits_data[7],io_imem_resp_bits_data[30:25],
    io_imem_resp_bits_data[11:8],1'h0}; // @[Cat.scala 30:58]
  wire [31:0] br_target = pc_reg + imm_b_sext; // @[dpath.scala 153:30]
  wire  _T_10 = ~io_ctl_stall; // @[dpath.scala 62:10]
  wire [4:0] rs2_addr = io_imem_resp_bits_data[24:20]; // @[dpath.scala 77:23]
  wire [4:0] wb_addr = io_imem_resp_bits_data[11:7]; // @[dpath.scala 78:23]
  wire  wb_wen = io_ctl_rf_wen & ~io_ctl_exception; // @[dpath.scala 81:31]
  wire  _T_14 = wb_addr != 5'h0; // @[dpath.scala 86:29]
  wire  _T_103 = io_ctl_wb_sel == 2'h0; // @[dpath.scala 176:34]
  wire  _T_55 = io_ctl_alu_fun == 4'h1; // @[dpath.scala 139:35]
  wire  _T_43 = io_ctl_op1_sel == 2'h0; // @[dpath.scala 119:32]
  wire  _T_44 = io_ctl_op1_sel == 2'h1; // @[dpath.scala 120:32]
  wire [19:0] imm_u = io_imem_resp_bits_data[31:12]; // @[dpath.scala 106:20]
  wire [31:0] imm_u_sext = {imm_u,12'h0}; // @[Cat.scala 30:58]
  wire  _T_45 = io_ctl_op1_sel == 2'h2; // @[dpath.scala 121:32]
  wire [31:0] imm_z = {27'h0,rs1_addr}; // @[Cat.scala 30:58]
  wire [31:0] _T_46 = _T_45 ? imm_z : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _T_47 = _T_44 ? imm_u_sext : _T_46; // @[Mux.scala 98:16]
  wire [31:0] alu_op1 = _T_43 ? rs1_data : _T_47; // @[Mux.scala 98:16]
  wire  _T_48 = io_ctl_op2_sel == 2'h0; // @[dpath.scala 125:32]
  wire [31:0] rs2_data = rs2_addr != 5'h0 ? regfile_MPORT_4_data : 32'h0; // @[dpath.scala 99:22]
  wire  _T_49 = io_ctl_op2_sel == 2'h3; // @[dpath.scala 126:32]
  wire  _T_50 = io_ctl_op2_sel == 2'h1; // @[dpath.scala 127:32]
  wire  _T_51 = io_ctl_op2_sel == 2'h2; // @[dpath.scala 128:32]
  wire [11:0] imm_s = {io_imem_resp_bits_data[31:25],wb_addr}; // @[Cat.scala 30:58]
  wire [19:0] _T_35 = imm_s[11] ? 20'hfffff : 20'h0; // @[Bitwise.scala 72:12]
  wire [31:0] imm_s_sext = {_T_35,io_imem_resp_bits_data[31:25],wb_addr}; // @[Cat.scala 30:58]
  wire [31:0] _T_52 = _T_51 ? imm_s_sext : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _T_53 = _T_50 ? imm_i_sext : _T_52; // @[Mux.scala 98:16]
  wire [31:0] _T_54 = _T_49 ? pc_reg : _T_53; // @[Mux.scala 98:16]
  wire [31:0] alu_op2 = _T_48 ? rs2_data : _T_54; // @[Mux.scala 98:16]
  wire [31:0] _T_57 = alu_op1 + alu_op2; // @[dpath.scala 139:61]
  wire  _T_58 = io_ctl_alu_fun == 4'h2; // @[dpath.scala 140:35]
  wire [31:0] _T_60 = alu_op1 - alu_op2; // @[dpath.scala 140:61]
  wire  _T_61 = io_ctl_alu_fun == 4'h6; // @[dpath.scala 141:35]
  wire [31:0] _T_62 = alu_op1 & alu_op2; // @[dpath.scala 141:61]
  wire  _T_63 = io_ctl_alu_fun == 4'h7; // @[dpath.scala 142:35]
  wire [31:0] _T_64 = alu_op1 | alu_op2; // @[dpath.scala 142:61]
  wire  _T_65 = io_ctl_alu_fun == 4'h8; // @[dpath.scala 143:35]
  wire [31:0] _T_66 = alu_op1 ^ alu_op2; // @[dpath.scala 143:61]
  wire  _T_67 = io_ctl_alu_fun == 4'h9; // @[dpath.scala 144:35]
  wire [31:0] _T_68 = _T_43 ? rs1_data : _T_47; // @[dpath.scala 144:67]
  wire [31:0] _T_69 = _T_48 ? rs2_data : _T_54; // @[dpath.scala 144:86]
  wire  _T_70 = $signed(_T_68) < $signed(_T_69); // @[dpath.scala 144:70]
  wire  _T_71 = io_ctl_alu_fun == 4'ha; // @[dpath.scala 145:35]
  wire  _T_72 = alu_op1 < alu_op2; // @[dpath.scala 145:61]
  wire  _T_73 = io_ctl_alu_fun == 4'h3; // @[dpath.scala 146:35]
  wire [4:0] alu_shamt = alu_op2[4:0]; // @[dpath.scala 136:27]
  wire [62:0] _GEN_11 = {{31'd0}, alu_op1}; // @[dpath.scala 146:62]
  wire [62:0] _T_74 = _GEN_11 << alu_shamt; // @[dpath.scala 146:62]
  wire  _T_76 = io_ctl_alu_fun == 4'h5; // @[dpath.scala 147:35]
  wire [31:0] _T_79 = $signed(_T_68) >>> alu_shamt; // @[dpath.scala 147:90]
  wire  _T_80 = io_ctl_alu_fun == 4'h4; // @[dpath.scala 148:35]
  wire [31:0] _T_81 = alu_op1 >> alu_shamt; // @[dpath.scala 148:61]
  wire  _T_82 = io_ctl_alu_fun == 4'hb; // @[dpath.scala 149:35]
  wire [31:0] _T_83 = _T_82 ? alu_op1 : 32'h0; // @[Mux.scala 98:16]
  wire [31:0] _T_84 = _T_80 ? _T_81 : _T_83; // @[Mux.scala 98:16]
  wire [31:0] _T_85 = _T_76 ? _T_79 : _T_84; // @[Mux.scala 98:16]
  wire [31:0] _T_86 = _T_73 ? _T_74[31:0] : _T_85; // @[Mux.scala 98:16]
  wire [31:0] _T_87 = _T_71 ? {{31'd0}, _T_72} : _T_86; // @[Mux.scala 98:16]
  wire [31:0] _T_88 = _T_67 ? {{31'd0}, _T_70} : _T_87; // @[Mux.scala 98:16]
  wire [31:0] _T_89 = _T_65 ? _T_66 : _T_88; // @[Mux.scala 98:16]
  wire [31:0] _T_90 = _T_63 ? _T_64 : _T_89; // @[Mux.scala 98:16]
  wire [31:0] _T_91 = _T_61 ? _T_62 : _T_90; // @[Mux.scala 98:16]
  wire [31:0] _T_92 = _T_58 ? _T_60 : _T_91; // @[Mux.scala 98:16]
  wire [31:0] alu_out = _T_55 ? _T_57 : _T_92; // @[Mux.scala 98:16]
  wire  _T_104 = io_ctl_wb_sel == 2'h1; // @[dpath.scala 177:34]
  wire  _T_105 = io_ctl_wb_sel == 2'h2; // @[dpath.scala 178:34]
  wire  _T_106 = io_ctl_wb_sel == 2'h3; // @[dpath.scala 179:34]
  wire [31:0] _T_107 = _T_106 ? csr_io_rw_rdata : alu_out; // @[Mux.scala 98:16]
  wire [31:0] _T_108 = _T_105 ? pc_plus4 : _T_107; // @[Mux.scala 98:16]
  wire [31:0] _T_109 = _T_104 ? io_dmem_resp_bits_data : _T_108; // @[Mux.scala 98:16]
  wire [31:0] wb_data = _T_103 ? alu_out : _T_109; // @[Mux.scala 98:16]
  wire [31:0] _T_112 = rs1_addr != 5'h0 ? regfile_MPORT_3_data : 32'h0; // @[dpath.scala 186:37]
  wire [31:0] _T_113 = rs2_addr != 5'h0 ? regfile_MPORT_4_data : 32'h0; // @[dpath.scala 186:57]
  wire [31:0] _T_116 = csr_io_time; // @[dpath.scala 198:18]
  wire [7:0] _T_117 = io_ctl_stall ? 8'h53 : 8'h20; // @[dpath.scala 209:10]
  wire [7:0] _T_119 = 3'h1 == io_ctl_pc_sel ? 8'h42 : 8'h3f; // @[Mux.scala 80:57]
  wire [7:0] _T_121 = 3'h2 == io_ctl_pc_sel ? 8'h4a : _T_119; // @[Mux.scala 80:57]
  wire [7:0] _T_123 = 3'h3 == io_ctl_pc_sel ? 8'h52 : _T_121; // @[Mux.scala 80:57]
  wire [7:0] _T_125 = 3'h4 == io_ctl_pc_sel ? 8'h45 : _T_123; // @[Mux.scala 80:57]
  wire [7:0] _T_127 = 3'h0 == io_ctl_pc_sel ? 8'h20 : _T_125; // @[Mux.scala 80:57]
  wire [7:0] _T_128 = csr_io_exception ? 8'h58 : 8'h20; // @[dpath.scala 216:10]
  CSRFile csr ( // @[dpath.scala 158:20]
    .clock(csr_clock),
    .reset(csr_reset),
    .io_rw_cmd(csr_io_rw_cmd),
    .io_rw_rdata(csr_io_rw_rdata),
    .io_rw_wdata(csr_io_rw_wdata),
    .io_eret(csr_io_eret),
    .io_decode_csr(csr_io_decode_csr),
    .io_status_debug(csr_io_status_debug),
    .io_status_prv(csr_io_status_prv),
    .io_status_sd(csr_io_status_sd),
    .io_status_zero1(csr_io_status_zero1),
    .io_status_tsr(csr_io_status_tsr),
    .io_status_tw(csr_io_status_tw),
    .io_status_tvm(csr_io_status_tvm),
    .io_status_mxr(csr_io_status_mxr),
    .io_status_sum(csr_io_status_sum),
    .io_status_mprv(csr_io_status_mprv),
    .io_status_xs(csr_io_status_xs),
    .io_status_fs(csr_io_status_fs),
    .io_status_mpp(csr_io_status_mpp),
    .io_status_hpp(csr_io_status_hpp),
    .io_status_spp(csr_io_status_spp),
    .io_status_mpie(csr_io_status_mpie),
    .io_status_hpie(csr_io_status_hpie),
    .io_status_spie(csr_io_status_spie),
    .io_status_upie(csr_io_status_upie),
    .io_status_mie(csr_io_status_mie),
    .io_status_hie(csr_io_status_hie),
    .io_status_sie(csr_io_status_sie),
    .io_status_uie(csr_io_status_uie),
    .io_evec(csr_io_evec),
    .io_exception(csr_io_exception),
    .io_retire(csr_io_retire),
    .io_pc(csr_io_pc),
    .io_time(csr_io_time)
  );
  assign regfile_MPORT_1_addr = io_ddpath_addr;
  assign regfile_MPORT_1_data = regfile[regfile_MPORT_1_addr]; // @[dpath.scala 84:21]
  assign regfile_MPORT_3_addr = io_imem_resp_bits_data[19:15];
  assign regfile_MPORT_3_data = regfile[regfile_MPORT_3_addr]; // @[dpath.scala 84:21]
  assign regfile_MPORT_4_addr = io_imem_resp_bits_data[24:20];
  assign regfile_MPORT_4_data = regfile[regfile_MPORT_4_addr]; // @[dpath.scala 84:21]
  assign regfile_MPORT_data = _T_103 ? alu_out : _T_109;
  assign regfile_MPORT_addr = io_imem_resp_bits_data[11:7];
  assign regfile_MPORT_mask = 1'h1;
  assign regfile_MPORT_en = wb_wen & _T_14;
  assign regfile_MPORT_2_data = io_ddpath_wdata;
  assign regfile_MPORT_2_addr = io_ddpath_addr;
  assign regfile_MPORT_2_mask = 1'h1;
  assign regfile_MPORT_2_en = 1'h1;
  assign io_ddpath_rdata = regfile_MPORT_1_data; // @[dpath.scala 92:20]
  assign io_imem_req_bits_addr = pc_reg; // @[dpath.scala 70:26]
  assign io_dmem_req_bits_addr = _T_55 ? _T_57 : _T_92; // @[Mux.scala 98:16]
  assign io_dmem_req_bits_data = rs2_addr != 5'h0 ? regfile_MPORT_4_data : 32'h0; // @[dpath.scala 99:22]
  assign io_dat_inst = io_imem_resp_bits_data; // @[dpath.scala 72:18]
  assign io_dat_br_eq = rs1_data == rs2_data; // @[dpath.scala 185:31]
  assign io_dat_br_lt = $signed(_T_112) < $signed(_T_113); // @[dpath.scala 186:40]
  assign io_dat_br_ltu = rs1_data < rs2_data; // @[dpath.scala 187:40]
  assign io_dat_csr_eret = csr_io_eret; // @[dpath.scala 169:20]
  assign csr_clock = clock;
  assign csr_reset = reset;
  assign csr_io_rw_cmd = io_ctl_csr_cmd; // @[dpath.scala 161:20]
  assign csr_io_rw_wdata = _T_55 ? _T_57 : _T_92; // @[Mux.scala 98:16]
  assign csr_io_decode_csr = io_imem_resp_bits_data[31:20]; // @[dpath.scala 160:29]
  assign csr_io_exception = io_ctl_exception; // @[dpath.scala 165:21]
  assign csr_io_retire = ~(io_ctl_stall | io_ctl_exception); // @[dpath.scala 164:24]
  assign csr_io_pc = pc_reg; // @[dpath.scala 166:21]
  always @(posedge clock) begin
    if(regfile_MPORT_en & regfile_MPORT_mask) begin
      regfile[regfile_MPORT_addr] <= regfile_MPORT_data; // @[dpath.scala 84:21]
    end
    if(regfile_MPORT_2_en & regfile_MPORT_2_mask) begin
      regfile[regfile_MPORT_2_addr] <= regfile_MPORT_2_data; // @[dpath.scala 84:21]
    end
    if (reset) begin // @[dpath.scala 60:24]
      pc_reg <= 32'h80000000; // @[dpath.scala 60:24]
    end else if (_T_10) begin // @[dpath.scala 63:4]
      if (_T) begin // @[Mux.scala 98:16]
        pc_reg <= pc_plus4;
      end else if (_T_1) begin // @[Mux.scala 98:16]
        pc_reg <= br_target;
      end else begin
        pc_reg <= _T_7;
      end
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          //$fwrite(32'h80000002,
            //"Cyc= %d [%d] pc=[%x] W[r%d=%x][%d] Op1=[r%d][%x] Op2=[r%d][%x] inst=[%x] %c%c%c DASM(%x)\n",_T_116,
            //csr_io_retire,pc_reg,wb_addr,wb_data,wb_wen,rs1_addr,alu_op1,rs2_addr,alu_op2,io_imem_resp_bits_data,_T_117,
            //_T_127,_T_128,io_imem_resp_bits_data); // @[dpath.scala 197:10]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    regfile[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  pc_reg = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule // DatPath

module Core(
  input         clock,
  input         reset,
  output [31:0] io_imem_req_bits_addr,
  input  [31:0] io_imem_resp_bits_data,
  output        io_dmem_req_valid,
  output [31:0] io_dmem_req_bits_addr,
  output [31:0] io_dmem_req_bits_data,
  output        io_dmem_req_bits_fcn,
  output [2:0]  io_dmem_req_bits_typ,
  input         io_dmem_resp_valid,
  input  [31:0] io_dmem_resp_bits_data,
  input  [4:0]  io_ddpath_addr,
  input  [31:0] io_ddpath_wdata,
  output [31:0] io_ddpath_rdata
);
  wire  c_io_dmem_req_valid; // @[core.scala 37:18]
  wire  c_io_dmem_req_bits_fcn; // @[core.scala 37:18]
  wire [2:0] c_io_dmem_req_bits_typ; // @[core.scala 37:18]
  wire  c_io_dmem_resp_valid; // @[core.scala 37:18]
  wire [31:0] c_io_dat_inst; // @[core.scala 37:18]
  wire  c_io_dat_br_eq; // @[core.scala 37:18]
  wire  c_io_dat_br_lt; // @[core.scala 37:18]
  wire  c_io_dat_br_ltu; // @[core.scala 37:18]
  wire  c_io_dat_csr_eret; // @[core.scala 37:18]
  wire  c_io_ctl_stall; // @[core.scala 37:18]
  wire [2:0] c_io_ctl_pc_sel; // @[core.scala 37:18]
  wire [1:0] c_io_ctl_op1_sel; // @[core.scala 37:18]
  wire [1:0] c_io_ctl_op2_sel; // @[core.scala 37:18]
  wire [3:0] c_io_ctl_alu_fun; // @[core.scala 37:18]
  wire [1:0] c_io_ctl_wb_sel; // @[core.scala 37:18]
  wire  c_io_ctl_rf_wen; // @[core.scala 37:18]
  wire [2:0] c_io_ctl_csr_cmd; // @[core.scala 37:18]
  wire  c_io_ctl_exception; // @[core.scala 37:18]
  wire  d_clock; // @[core.scala 38:18]
  wire  d_reset; // @[core.scala 38:18]
  wire [4:0] d_io_ddpath_addr; // @[core.scala 38:18]
  wire [31:0] d_io_ddpath_wdata; // @[core.scala 38:18]
  wire [31:0] d_io_ddpath_rdata; // @[core.scala 38:18]
  wire [31:0] d_io_imem_req_bits_addr; // @[core.scala 38:18]
  wire [31:0] d_io_imem_resp_bits_data; // @[core.scala 38:18]
  wire [31:0] d_io_dmem_req_bits_addr; // @[core.scala 38:18]
  wire [31:0] d_io_dmem_req_bits_data; // @[core.scala 38:18]
  wire [31:0] d_io_dmem_resp_bits_data; // @[core.scala 38:18]
  wire  d_io_ctl_stall; // @[core.scala 38:18]
  wire [2:0] d_io_ctl_pc_sel; // @[core.scala 38:18]
  wire [1:0] d_io_ctl_op1_sel; // @[core.scala 38:18]
  wire [1:0] d_io_ctl_op2_sel; // @[core.scala 38:18]
  wire [3:0] d_io_ctl_alu_fun; // @[core.scala 38:18]
  wire [1:0] d_io_ctl_wb_sel; // @[core.scala 38:18]
  wire  d_io_ctl_rf_wen; // @[core.scala 38:18]
  wire [2:0] d_io_ctl_csr_cmd; // @[core.scala 38:18]
  wire  d_io_ctl_exception; // @[core.scala 38:18]
  wire [31:0] d_io_dat_inst; // @[core.scala 38:18]
  wire  d_io_dat_br_eq; // @[core.scala 38:18]
  wire  d_io_dat_br_lt; // @[core.scala 38:18]
  wire  d_io_dat_br_ltu; // @[core.scala 38:18]
  wire  d_io_dat_csr_eret; // @[core.scala 38:18]
  CtlPath c ( // @[core.scala 37:18]
    .io_dmem_req_valid(c_io_dmem_req_valid),
    .io_dmem_req_bits_fcn(c_io_dmem_req_bits_fcn),
    .io_dmem_req_bits_typ(c_io_dmem_req_bits_typ),
    .io_dmem_resp_valid(c_io_dmem_resp_valid),
    .io_dat_inst(c_io_dat_inst),
    .io_dat_br_eq(c_io_dat_br_eq),
    .io_dat_br_lt(c_io_dat_br_lt),
    .io_dat_br_ltu(c_io_dat_br_ltu),
    .io_dat_csr_eret(c_io_dat_csr_eret),
    .io_ctl_stall(c_io_ctl_stall),
    .io_ctl_pc_sel(c_io_ctl_pc_sel),
    .io_ctl_op1_sel(c_io_ctl_op1_sel),
    .io_ctl_op2_sel(c_io_ctl_op2_sel),
    .io_ctl_alu_fun(c_io_ctl_alu_fun),
    .io_ctl_wb_sel(c_io_ctl_wb_sel),
    .io_ctl_rf_wen(c_io_ctl_rf_wen),
    .io_ctl_csr_cmd(c_io_ctl_csr_cmd),
    .io_ctl_exception(c_io_ctl_exception)
  );
  DatPath d ( // @[core.scala 38:18]
    .clock(d_clock),
    .reset(d_reset),
    .io_ddpath_addr(d_io_ddpath_addr),
    .io_ddpath_wdata(d_io_ddpath_wdata),
    .io_ddpath_rdata(d_io_ddpath_rdata),
    .io_imem_req_bits_addr(d_io_imem_req_bits_addr),
    .io_imem_resp_bits_data(d_io_imem_resp_bits_data),
    .io_dmem_req_bits_addr(d_io_dmem_req_bits_addr),
    .io_dmem_req_bits_data(d_io_dmem_req_bits_data),
    .io_dmem_resp_bits_data(d_io_dmem_resp_bits_data),
    .io_ctl_stall(d_io_ctl_stall),
    .io_ctl_pc_sel(d_io_ctl_pc_sel),
    .io_ctl_op1_sel(d_io_ctl_op1_sel),
    .io_ctl_op2_sel(d_io_ctl_op2_sel),
    .io_ctl_alu_fun(d_io_ctl_alu_fun),
    .io_ctl_wb_sel(d_io_ctl_wb_sel),
    .io_ctl_rf_wen(d_io_ctl_rf_wen),
    .io_ctl_csr_cmd(d_io_ctl_csr_cmd),
    .io_ctl_exception(d_io_ctl_exception),
    .io_dat_inst(d_io_dat_inst),
    .io_dat_br_eq(d_io_dat_br_eq),
    .io_dat_br_lt(d_io_dat_br_lt),
    .io_dat_br_ltu(d_io_dat_br_ltu),
    .io_dat_csr_eret(d_io_dat_csr_eret)
  );
  assign io_imem_req_bits_addr = d_io_imem_req_bits_addr; // @[core.scala 43:11]
  assign io_dmem_req_valid = c_io_dmem_req_valid; // @[core.scala 47:21]
  assign io_dmem_req_bits_addr = d_io_dmem_req_bits_addr; // @[core.scala 46:11]
  assign io_dmem_req_bits_data = d_io_dmem_req_bits_data; // @[core.scala 46:11]
  assign io_dmem_req_bits_fcn = c_io_dmem_req_bits_fcn; // @[core.scala 49:24]
  assign io_dmem_req_bits_typ = c_io_dmem_req_bits_typ; // @[core.scala 48:24]
  assign io_ddpath_rdata = d_io_ddpath_rdata; // @[core.scala 51:15]
  assign c_io_dmem_resp_valid = io_dmem_resp_valid; // @[core.scala 45:11]
  assign c_io_dat_inst = d_io_dat_inst; // @[core.scala 40:13]
  assign c_io_dat_br_eq = d_io_dat_br_eq; // @[core.scala 40:13]
  assign c_io_dat_br_lt = d_io_dat_br_lt; // @[core.scala 40:13]
  assign c_io_dat_br_ltu = d_io_dat_br_ltu; // @[core.scala 40:13]
  assign c_io_dat_csr_eret = d_io_dat_csr_eret; // @[core.scala 40:13]
  assign d_clock = clock;
  assign d_reset = reset;
  assign d_io_ddpath_addr = io_ddpath_addr; // @[core.scala 51:15]
  assign d_io_ddpath_wdata = io_ddpath_wdata; // @[core.scala 51:15]
  assign d_io_imem_resp_bits_data = io_imem_resp_bits_data; // @[core.scala 43:11]
  assign d_io_dmem_resp_bits_data = io_dmem_resp_bits_data; // @[core.scala 46:11]
  assign d_io_ctl_stall = c_io_ctl_stall; // @[core.scala 39:13]
  assign d_io_ctl_pc_sel = c_io_ctl_pc_sel; // @[core.scala 39:13]
  assign d_io_ctl_op1_sel = c_io_ctl_op1_sel; // @[core.scala 39:13]
  assign d_io_ctl_op2_sel = c_io_ctl_op2_sel; // @[core.scala 39:13]
  assign d_io_ctl_alu_fun = c_io_ctl_alu_fun; // @[core.scala 39:13]
  assign d_io_ctl_wb_sel = c_io_ctl_wb_sel; // @[core.scala 39:13]
  assign d_io_ctl_rf_wen = c_io_ctl_rf_wen; // @[core.scala 39:13]
  assign d_io_ctl_csr_cmd = c_io_ctl_csr_cmd; // @[core.scala 39:13]
  assign d_io_ctl_exception = c_io_ctl_exception; // @[core.scala 39:13]
endmodule // Core

