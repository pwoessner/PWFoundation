//
//  Data+TempFileURL.swift
//  
//
//  Created by Woessner, Philipp on 19.02.22.
//

import Foundation

public extension Data {
	func getTempFileUrl() throws -> URL {
		let path = NSTemporaryDirectory()
		let url = URL(fileURLWithPath: path + UUID().uuidString)
		try self.write(to: url)
		return url
	}

	func getTempJSONFileUrl(fileName: String? = nil) throws -> URL {
		let path = NSTemporaryDirectory()
		let url = URL(fileURLWithPath: path + (fileName ?? UUID().uuidString)).appendingPathExtension("json")
		try self.write(to: url)
		return url
	}
}
