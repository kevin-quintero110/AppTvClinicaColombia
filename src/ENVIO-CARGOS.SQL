SELECT numero_factura
					,numero_consecutivo
					,tipo_servicio
					,codigo_servicio
					,descripcion_insumo
					,cantidad
					,CASE 
						WHEN glosa_total = '1'
							THEN precio
						ELSE ROUND(precio / cantidad)
						END AS precio
					,precio_cd
					,valor_cargo
					,valor_cubierto
					,transaccion
					,consecutivo_procedimiento
					,porcentaje
					,secuencia
					,envio_id
				FROM (
					(
						SELECT A.numero_factura
							,A.numero_consecutivo
							,A.tipo_servicio
							,A.codigo_servicio
							,A.descripcion_insumo
							,A.cantidad
							,A.precio
							,A.precio_cd
							,A.valor_cargo
							,A.valor_cubierto
							,A.transaccion
							,A.consecutivo_procedimiento
							,A.porcentaje
							,A.secuencia
							,A.cuenta_liquidacion_qx_id
							,A.envio_id
							,A.glosa_total
						FROM (
							SELECT FFC.prefijo || FFC.factura_fiscal AS numero_factura
								,FFC.factura_fiscal AS numero_consecutivo
								,TD.tipo_servicio_furips_id AS tipo_servicio
								,CASE 
									WHEN TD.tipo_servicio_furips_id IN (
											3
											,4
											,5
											,7
											,8
											)
										THEN ''
									WHEN CQ.transaccion IS NOT NULL
										OR TD.tipo_servicio_furips_id = 2
										THEN CD.cargo
									ELSE ''
									END AS codigo_servicio
								,TD.descripcion AS descripcion_insumo
								,CD.cantidad
								,CD.precio AS precio_cd
								,RS.valor_no_aceptado AS precio
								,RS.valor_no_aceptado AS valor_cargo
								,RS.valor_no_aceptado AS valor_cubierto
								,CQ.transaccion
								,CQ.consecutivo_procedimiento
								,CQ.porcentaje
								,CQ.secuencia
								,CA.cuenta_liquidacion_qx_id
								,ED.envio_id
								,RS.glosa_respuesta_id
								,'0'::bpchar AS glosa_total
							FROM cuentas_detalle AS CD
							INNER JOIN tarifarios_detalle TD ON (
									CD.cargo = TD.cargo
									AND CD.tarifario_id = TD.tarifario_id
									)
							LEFT JOIN cuentas_codigos_agrupamiento CA ON (CA.codigo_agrupamiento_id = CD.codigo_agrupamiento_id)
							LEFT JOIN cuentas_cargos_qx_procedimientos CQ ON (CD.transaccion = CQ.transaccion)
							LEFT JOIN cuentas_liquidaciones_qx_procedimientos CL ON (CQ.consecutivo_procedimiento = CL.consecutivo_procedimiento)
							INNER JOIN fac_facturas_cuentas AS FFC ON (CD.numerodecuenta = FFC.numerodecuenta)
							INNER JOIN envios_glosas_detalle AS ED ON (
									FFC.prefijo = ED.prefijo
									AND FFC.factura_fiscal = ED.factura_fiscal
									AND FFC.empresa_id = ED.empresa_id
									)
							INNER JOIN glosas_detalle_cargos GC ON (CD.transaccion = GC.transaccion)
							INNER JOIN glosas_respuestas_cargos RS ON (
									GC.glosa_detalle_cargo_id = RS.glosa_detalle_cargo_id
									AND GC.glosa_id = ED.glosa_id
									)
							WHERE CD.consecutivo IS NULL
								AND RS.valor_no_aceptado > 0
								AND ED.envio_id = 19878
							ORDER BY CA.cuenta_liquidacion_qx_id DESC
							) A
						INNER JOIN (
							SELECT MAX(GR.glosa_respuesta_id) AS glosa_respuesta_id
								,GR.glosa_id
								,ED.envio_id
							FROM envios_glosas_detalle AS ED
								,glosas_respuestas GR
							WHERE ED.glosa_id = GR.glosa_id
								AND ED.envio_id = 19878
							GROUP BY 2
								,3
							) MR ON (
								MR.glosa_respuesta_id = A.glosa_respuesta_id
								AND MR.envio_id = A.envio_id
								)
						)
					
					UNION ALL
					
					(
						SELECT A.numero_factura
							,A.numero_consecutivo
							,A.tipo_servicio
							,A.codigo_servicio
							,A.descripcion_insumo
							,A.cantidad
							,A.precio
							,A.precio_cd
							,A.valor_cargo
							,A.valor_cubierto
							,A.transaccion
							,A.consecutivo_procedimiento
							,A.porcentaje
							,A.secuencia
							,A.cuenta_liquidacion_qx_id
							,A.envio_id
							,A.glosa_total
						FROM (
							SELECT FFC.prefijo || FFC.factura_fiscal AS numero_factura
								,FFC.factura_fiscal AS numero_consecutivo
								,TD.tipo_servicio_furips_id AS tipo_servicio
								,CASE 
									WHEN TD.tipo_servicio_furips_id IN (
											3
											,4
											,5
											,7
											,8
											)
										THEN ''
									WHEN CQ.transaccion IS NOT NULL
										OR TD.tipo_servicio_furips_id = 2
										THEN CD.cargo
									ELSE ''
									END AS codigo_servicio
								,TD.descripcion AS descripcion_insumo
								,CD.cantidad
								,CD.precio
								,CD.precio AS precio_cd
								,CD.valor_cargo
								,CD.valor_cubierto
								,CQ.transaccion
								,CQ.consecutivo_procedimiento
								,CQ.porcentaje
								,CQ.secuencia
								,CA.cuenta_liquidacion_qx_id
								,ED.envio_id
								,RS.glosa_respuesta_id
								,'1'::bpchar AS glosa_total
							FROM cuentas_detalle AS CD
							INNER JOIN tarifarios_detalle TD ON (
									CD.cargo = TD.cargo
									AND CD.tarifario_id = TD.tarifario_id
									)
							LEFT JOIN cuentas_codigos_agrupamiento CA ON (CA.codigo_agrupamiento_id = CD.codigo_agrupamiento_id)
							LEFT JOIN cuentas_cargos_qx_procedimientos CQ ON (CD.transaccion = CQ.transaccion)
							LEFT JOIN cuentas_liquidaciones_qx_procedimientos CL ON (CQ.consecutivo_procedimiento = CL.consecutivo_procedimiento)
							INNER JOIN fac_facturas_cuentas AS FFC ON (CD.numerodecuenta = FFC.numerodecuenta)
							INNER JOIN envios_glosas_detalle AS ED ON (
									FFC.prefijo = ED.prefijo
									AND FFC.factura_fiscal = ED.factura_fiscal
									AND FFC.empresa_id = ED.empresa_id
									)
							INNER JOIN glosas GC ON (GC.glosa_id = ED.glosa_id)
							INNER JOIN glosas_respuestas RS ON (GC.glosa_id = RS.glosa_id)
							WHERE CD.consecutivo IS NULL
								AND GC.sw_glosa_total_factura = '1'
								AND (
									(
										CD.paquete_codigo_id IS NOT NULL
										AND CD.sw_paquete_facturado = '1'
										)
									OR (
										CD.paquete_codigo_id IS NULL
										AND CD.facturado = '1'
										)
									)
								AND ED.envio_id = 19878
							ORDER BY CA.cuenta_liquidacion_qx_id DESC
							) A
						INNER JOIN (
							SELECT MAX(GR.glosa_respuesta_id) AS glosa_respuesta_id
								,GR.glosa_id
								,ED.envio_id
							FROM envios_glosas_detalle AS ED
								,glosas_respuestas GR
							WHERE ED.glosa_id = GR.glosa_id
								AND ED.envio_id = 19878
							GROUP BY 2
								,3
							) MR ON (
								MR.glosa_respuesta_id = A.glosa_respuesta_id
								AND MR.envio_id = A.envio_id
								)
						)
					
					UNION ALL
					
					(
						SELECT CR.prefijo || CR.factura_fiscal AS numero_factura
							,CR.factura_fiscal AS numero_consecutivo
							,CR.tipo_servicio_furips_id AS tipo_servicio
							,CASE 
								WHEN CR.tipo_servicio_furips_id = '1'
									THEN CASE 
											WHEN CR.codigo_invima IS NOT NULL
												AND CR.codigo_cum IS NOT NULL
												THEN CR.codigo_cum
											WHEN CR.codigo_invima IS NOT NULL
												AND CR.codigo_cum IS NULL
												THEN CR.codigo_ium
											WHEN CR.codigo_invima IS NULL
												AND CR.codigo_ium IS NOT NULL
												THEN CR.codigo_ium
											END
								ELSE ''
								END AS codigo_servicio
							,CASE 
								WHEN CR.tipo_servicio_furips_id = '1'
									THEN CASE 
											WHEN (
													CR.codigo_invima IS NOT NULL
													AND CR.codigo_cum IS NOT NULL
													)
												OR (
													CR.codigo_invima IS NULL
													AND CR.codigo_ium IS NOT NULL
													)
												OR (
													CR.codigo_ium IS NOT NULL
													OR CR.codigo_cum IS NOT NULL
													)
												THEN ''
											ELSE CR.descripcion_insumo
											END
								ELSE CR.descripcion_insumo
								END AS descripcion_insumo
							,CR.cantidad
							,CR.precio
							,CR.precio_cd
							,CR.valor_cargo
							,CR.valor_cubierto
							,NULL AS transaccion
							,NULL AS consecutivo_procedimiento
							,NULL AS porcentaje
							,NULL AS secuencia
							,NULL AS cuenta_liquidacion_qx_id
							,CR.envio_id
							,CR.glosa_total
						FROM (
							(
								SELECT C.prefijo
									,C.factura_fiscal
									,C.codigo_producto
									,COALESCE(NULLIF(GI.can_objetada, 0), C.cantidad) AS cantidad
									,RS.valor_no_aceptado AS precio
									,C.precio_cd AS precio_cd
									,RS.valor_no_aceptado AS valor_cargo
									,RS.valor_no_aceptado AS valor_cubierto
									,med.codigo_cum
									,CASE 
										WHEN med.codigo_medicamento IS NULL
											THEN '0'
										ELSE '1'
										END AS sw_medicamento
									,CASE 
										WHEN med.codigo_medicamento IS NULL
											THEN D.descripcion || ' ' || C.nombre_tercero
										ELSE ' '
										END AS descripcion_insumo
									,D.tipo_servicio_furips_id
									,med.codigo_ium
									,d.codigo_invima
									,C.envio_id
									,'0'::bpchar AS glosa_total
								FROM (
									SELECT SUM(cantidad) AS cantidad
										,SUM(valor_cubierto) AS valor_cubierto
										,SUM(valor_cargo) AS valor_cargo
										,codigo_producto
										,departamento
										,prefijo
										,factura_fiscal
										,precio
										,precio_cd
										,glosa_id
										,envio_id
										,nombre_tercero
									FROM (
										(
											SELECT SUM(COALESCE(CD.cantidad, 0)) AS cantidad
												,FF.prefijo
												,FF.factura_fiscal
												,BD.codigo_producto
												,CD.precio
												,CD.precio AS precio_cd
												,EG.glosa_id
												,CD.departamento
												,EG.envio_id
												,MAX(COALESCE(PP.nombre_tercero, '')) AS nombre_tercero
												,SUM(COALESCE(CD.valor_cubierto, 0)) AS valor_cubierto
												,SUM(COALESCE(CD.valor_cargo, 0)) AS valor_cargo
											FROM cuentas_detalle CD
												,bodegas_documentos_d BD
											LEFT JOIN view_proveedor_productos PP ON (
													BD.codigo_producto = PP.codigo_producto
													AND BD.fecha_vencimiento = PP.fecha_vencimiento
													AND BD.lote = PP.lote
													)
												,fac_facturas_cuentas FF
												,envios_glosas_detalle EG
											WHERE FF.numerodecuenta = CD.numerodecuenta
												AND FF.prefijo = EG.prefijo
												AND FF.factura_fiscal = EG.factura_fiscal
												AND FF.empresa_id = EG.empresa_id
												AND CD.tarifario_id = 'SYS'
												AND CD.cargo = 'IMD'
												AND (
													(
														CD.facturado = '1'
														AND CD.paquete_codigo_id IS NULL
														)
													OR (
														CD.sw_paquete_facturado = '1'
														AND CD.paquete_codigo_id IS NOT NULL
														)
													)
												AND CD.consecutivo = BD.consecutivo
												AND EG.envio_id = 19878
											GROUP BY 2
												,3
												,4
												,5
												,6
												,7
												,8
												,9
											ORDER BY BD.codigo_producto
											)
										
										UNION ALL
										
										(
											SELECT SUM(COALESCE(CD.cantidad, 0)) * - 1 AS cantidad
												,FF.prefijo
												,FF.factura_fiscal
												,BD.codigo_producto
												,CD.precio
												,CD.precio AS precio_cd
												,EG.glosa_id
												,CD.departamento
												,EG.envio_id
												,MAX(COALESCE(PP.nombre_tercero, '')) AS nombre_tercero
												,SUM(COALESCE(CD.valor_cubierto, 0)) * - 1 AS valor_cubierto
												,SUM(COALESCE(CD.valor_cargo, 0)) * - 1 AS valor_cargo
											FROM cuentas_detalle CD
												,bodegas_documentos_d BD
											LEFT JOIN view_proveedor_productos PP ON (
													BD.codigo_producto = PP.codigo_producto
													AND BD.fecha_vencimiento = PP.fecha_vencimiento
													AND BD.lote = PP.lote
													)
												,fac_facturas_cuentas FF
												,envios_glosas_detalle EG
											WHERE FF.numerodecuenta = CD.numerodecuenta
												AND FF.prefijo = EG.prefijo
												AND FF.factura_fiscal = EG.factura_fiscal
												AND FF.empresa_id = EG.empresa_id
												AND CD.tarifario_id = 'SYS'
												AND CD.cargo = 'DIMD'
												AND (
													(
														CD.facturado = '1'
														AND CD.paquete_codigo_id IS NULL
														)
													OR (
														CD.sw_paquete_facturado = '1'
														AND CD.paquete_codigo_id IS NOT NULL
														)
													)
												AND CD.consecutivo = BD.consecutivo
												AND EG.envio_id = 19878
											GROUP BY 2
												,3
												,4
												,5
												,6
												,7
												,8
												,9
											ORDER BY BD.codigo_producto
											)
										) A
									GROUP BY codigo_producto
										,departamento
										,prefijo
										,factura_fiscal
										,precio
										,precio_cd
										,glosa_id
										,envio_id
										,nombre_tercero
									) C
								INNER JOIN glosas_detalle_inventarios GI ON (
										C.codigo_producto = GI.codigo_producto
										AND (
											GI.departamento IS NULL
											OR Gi.departamento = C.departamento
											)
										AND GI.glosa_id = C.glosa_id
										)
								INNER JOIN glosas_respuestas_inventarios RS ON (GI.glosa_detalle_inventario_id = RS.glosa_detalle_inventario_id)
								INNER JOIN (
									SELECT MAX(GR.glosa_respuesta_id) AS glosa_respuesta_id
										,GR.glosa_id
										,ED.envio_id
									FROM envios_glosas_detalle AS ED
										,glosas_respuestas GR
									WHERE ED.glosa_id = GR.glosa_id
										AND ED.envio_id = 19878
									GROUP BY 2
										,3
									) MR ON (
										MR.glosa_respuesta_id = RS.glosa_respuesta_id
										AND MR.envio_id = C.envio_id
										)
								INNER JOIN inventarios_productos D ON (C.codigo_producto = D.codigo_producto)
								INNER JOIN inv_clases_inventarios IC ON (
										D.grupo_id = IC.grupo_id
										AND D.clase_id = IC.clase_id
										)
								LEFT JOIN medicamentos med ON (D.codigo_producto = med.codigo_medicamento)
								WHERE RS.valor_no_aceptado > 0
								)
							
							UNION ALL
							
							(
								SELECT t.prefijo
									,t.factura_fiscal
									,t.codigo_producto
									,SUM(t.cantidad) AS cantidad
									,t.precio
									,t.precio AS precio_cd
									,SUM(t.valor_cargo) AS valor_cargo
									,SUM(t.valor_cubierto) AS valor_cubierto
									,med.codigo_cum
									,CASE 
										WHEN med.codigo_medicamento IS NULL
											THEN '0'
										ELSE '1'
										END AS sw_medicamento
									,CASE 
										WHEN med.codigo_medicamento IS NULL
											THEN d.descripcion || ' ' || MAX(t.nombre_tercero)
										ELSE ' '
										END AS descripcion_insumo
									,D.tipo_servicio_furips_id
									,med.codigo_ium
									,d.codigo_invima
									,t.envio_id
									,'1'::bpchar AS glosa_total
								FROM (
									(
										SELECT FFC.prefijo
											,FFC.factura_fiscal
											,b.codigo_producto
											,SUM(a.cantidad) AS cantidad
											,a.precio
											,a.precio AS precio_cd
											,SUM(a.valor_cargo) AS valor_cargo
											,SUM(a.valor_cubierto) AS valor_cubierto
											,ED.envio_id
											,MAX(COALESCE(PP.nombre_tercero, '')) AS nombre_tercero
										FROM envios_glosas_detalle AS ED
											,fac_facturas_cuentas AS FFC
											,cuentas_detalle a
											,bodegas_documentos_d b
										LEFT JOIN view_proveedor_productos PP ON (
												b.codigo_producto = PP.codigo_producto
												AND b.fecha_vencimiento = PP.fecha_vencimiento
												AND b.lote = PP.lote
												)
											,glosas GL
										WHERE FFC.prefijo = ED.prefijo
											AND FFC.factura_fiscal = ED.factura_fiscal
											AND FFC.empresa_id = ED.empresa_id
											AND a.numerodecuenta = FFC.numerodecuenta
											AND a.cargo = 'IMD'
											AND a.consecutivo = b.consecutivo
											AND (
												(
													a.paquete_codigo_id IS NOT NULL
													AND a.sw_paquete_facturado = '1'
													)
												OR (
													a.paquete_codigo_id IS NULL
													AND a.facturado = '1'
													)
												)
											AND ED.glosa_id = GL.glosa_id
											AND GL.sw_glosa_total_factura = '1'
											AND ED.envio_id = 19878
										GROUP BY FFC.prefijo
											,FFC.factura_fiscal
											,b.codigo_producto
											,a.precio
											,ED.envio_id
										)
									
									UNION ALL
									
									(
										SELECT FFC.prefijo
											,FFC.factura_fiscal
											,b.codigo_producto
											,SUM(a.cantidad * - 1) AS cantidad
											,a.precio
											,a.precio AS precio_cd
											,SUM(a.valor_cargo) AS valor_cargo
											,SUM(a.valor_cubierto) AS valor_cubierto
											,ED.envio_id
											,MAX(COALESCE(PP.nombre_tercero, '')) AS nombre_tercero
										FROM envios_glosas_detalle AS ED
											,fac_facturas_cuentas AS FFC
											,cuentas_detalle a
											,bodegas_documentos_d b
										LEFT JOIN view_proveedor_productos PP ON (
												b.codigo_producto = PP.codigo_producto
												AND b.fecha_vencimiento = PP.fecha_vencimiento
												AND b.lote = PP.lote
												)
											,glosas GL
										WHERE FFC.prefijo = ED.prefijo
											AND FFC.factura_fiscal = ED.factura_fiscal
											AND FFC.empresa_id = ED.empresa_id
											AND a.numerodecuenta = FFC.numerodecuenta
											AND a.cargo = 'DIMD'
											AND a.consecutivo = b.consecutivo
											AND (
												(
													a.paquete_codigo_id IS NOT NULL
													AND a.sw_paquete_facturado = '1'
													)
												OR (
													a.paquete_codigo_id IS NULL
													AND a.facturado = '1'
													)
												)
											AND ED.glosa_id = GL.glosa_id
											AND GL.sw_glosa_total_factura = '1'
											AND ED.envio_id = 19878
										GROUP BY FFC.prefijo
											,FFC.factura_fiscal
											,b.codigo_producto
											,a.precio
											,ED.envio_id
										)
									) t
									,inventarios_productos d
								INNER JOIN inv_clases_inventarios IC ON (
										d.grupo_id = IC.grupo_id
										AND d.clase_id = IC.clase_id
										)
								LEFT JOIN medicamentos med ON (d.codigo_producto = med.codigo_medicamento)
								WHERE t.codigo_producto = d.codigo_producto
								GROUP BY t.prefijo
									,t.factura_fiscal
									,t.codigo_producto
									,t.precio
									,t.precio_cd
									,med.codigo_cum
									,med.codigo_medicamento
									,d.tipo_servicio_furips_id
									,med.codigo_ium
									,t.envio_id
									,d.codigo_invima
									,d.descripcion
								)
							) CR
						WHERE CR.cantidad > 0
						)
					) FR
				ORDER BY 1
					,10